//Aqui vamos a crear un singleton

import 'dart:io';

import 'package:path/path.dart'; //De aqui importamos el join() para concatenar la direccion
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:paws/src/models/usuario.dart';
export 'package:paws/src/models/usuario.dart';

class DBProvider {
  //--------------------------------------------------------------------------------------------
  //-------- Nos aseguramos de siempre crear la misma instancia de nuestro objeto --------------
  static Database? _database; //Propiedad estatica
  //Ahora vamos a crear una instancia de esta clase que se esta creando
  static final DBProvider db = DBProvider
      ._(); // '_' es el constructor privado. Es comun ver singletons con constructor privado de esta manera
  DBProvider._(); //Cremos el contructor privado
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------
  //------- Creamos el metodo con el que vamos a acceder a nuestra base de datos ---------------
  //Este metodo va a ser async porque nuestra base de datos no es sincrona, por lo que debemos esperar a obtener las respuestas
  Future<Database?> get database async {
    if (_database != null) return _database;

    //Si es la primera vez que se instancia la base de datos
    _database = await initDB();
    return _database!;
  }
  //--------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------

  //Este metodo initDB va a tener todos los procedimientos para iniciar nuestra base de datos
  Future<Database> initDB() async {
    //Path de donde almacenaremos nuestra base de datos. Cuando se borra la aplicación tambien se va a ir esta base de datos
    Directory documentsDirectory =
        await getApplicationDocumentsDirectory(); //metodo de path provider, y Directory de dart:io

    //join() nos va a servir pedazos de direcciones (path), para construir un directorio completo
    final path = join(documentsDirectory.path,
        'UsuariosDB.db'); //lo improtamos de path (que ya viene por defecto en flutter)
    //'ScanDB.db' es la direccion de SQLite. Es importante poner la extension .db
    print(path);

    return await openDatabase(
      path, //El path que acabamos de crear arriba
      //Cuando modificamos el numero de version se vuelve a correr la creacion entera de la base de datos
      version:
          1, //Debemos aumentar este numero cuando se modifica la estructura de la base datos
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        //Asi indicamos un String multilinea para Dart
        //Scans es el nombre de la tabla
        await db.execute('''
          CREATE TABLE Users(
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  //Esta es la forma corta de crear una insercion en la base de datos
  Future<int> nuevoUsuario(Usuario nuevoUsuario) async {
    //Obtenemos la referencia a la base de datos y esperamos a que este lista
    final db =
        await database; //database es nuestro get-er de arriba. Debemos esperar a que se genere

    //Verificamos que el elemento no exista ya en la base de datos
    Usuario? isUsuario = await getUsuarioByEmail(nuevoUsuario.email);
    if (isUsuario == null) {
      //Si el elemento no existe, lo agregamos
      //nuevoUsuario.toJson() es un mapa de la forma Map<String, dynamic>
      print('Elemento agregado con exito');
      return await db!.insert(
          'Scans', nuevoUsuario.toJson()); //'Scans' es el nombre de latabla
      //res es el indice del ultimo registro insertado, o sea su posicion en la tabla
    } else {
      print('El elemento insertado ya existe');
      return -1;
    }
  }

  //btener un registro
  Future<Usuario?> getUsuarioByEmail(String email) async {
    //Obtenemos la referencia a la base de datos
    final db = await database;

    //Solicitamos los datos a la database llamada 'Scans' y nos regresa una LISTA con el Mapa
    final res =
        await db!.query('Scans', where: 'email = ?', whereArgs: [email]);

    return res.isNotEmpty
        ? Usuario.fromJson(
            res.first) //res.first nos devuelve el primer valor de la lista res
        : null; //Si la lista esta vacia devuelve un null
  }

  //btener un registro
  Future<Usuario?> getUsuarioById(int? id) async {
    //Obtenemos la referencia a la base de datos
    final db = await database;

    //Solicitamos los datos a la database llamada 'Scans' y nos regresa una LISTA con el Mapa
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty
        ? Usuario.fromJson(
            res.first) //res.first nos devuelve el primer valor de la lista res
        : null; //Si la lista esta vacia devuelve un null
  }

  //Obtener una lista con todos los Scans
  Future<List<Usuario>> getAllUsuarios() async {
    //Obtenemos la referencia a la base de datos
    final db = await database;

    //Solicitamos los datos a la database llamada 'Scans' y nos regresa una LISTA con el Mapa
    final res = await db!.query('Scans');

    return res.isNotEmpty
        ? res.map((s) => Usuario.fromJson(s)).toList()
        : []; //Si la lista esta vacia devuelve un null
  }

  //Actualizar elemento de la nase de datos por su ID. Este Future devuelve el numero de elementos actualizados
  Future<int> updateUsuario(Usuario nuevoUsuario) async {
    //Creamos la instancia de la base de datos
    final db = await database;

    //Verificamos que el elemento no exista ya en la base de datos
    Usuario? isScan = await getUsuarioById(nuevoUsuario.id);
    if (isScan == null) {
      //Si el elemento no existe, lo agregamos

      //nuevoUsuario.toJson() es un mapa de la forma Map<String, dynamic>
      print('El elemento no existia. Se ha insertado.');
      return await db!.insert(
          'Scans', nuevoUsuario.toJson()); //'Scans' es el nombre de latabla
      //res es el indice del ultimo registro insertado, o sea su posicion en la tabla

    } else {
      print('El elemento se ha actualizado');
      //Realizamos una actualizacion por ID
      //Si no le ponemos los argumentos where y whereArgs TODOS los elementos se actualizan.
      return await db!.update('Scans', nuevoUsuario.toJson(),
          where: 'id = ?', whereArgs: [nuevoUsuario.id]);
    }
  }

  //Eliminar un elemento de la base de datos. El Future nos devuelve el numero de elementos borrados
  Future<int> deleteUsuarioById(int id) async {
    //Creamos una instancia de la base de datos
    final db = await database;

    //Realizamos al solicitus de al base de datos que eliminie el elemento con id = id
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    //Si no ponemos el argumento where se borra toda la base de datos

    return res;
  }

  //Eliminar toda la base de datos. El Future nos devuelve el numero de elementos borrados
  Future<int> deleteAllUsuario() async {
    //Creamos una instancia de la base de datos
    final db = await database;

    //Realizamos al solicitus de al base de datos que eliminie el elemento con id = id
    final res = await db!.delete(
        'Scans'); //Esta es una alternativa para borrar toda la base de datos

    return res;
  }
}
