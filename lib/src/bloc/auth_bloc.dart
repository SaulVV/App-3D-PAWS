//RXDart es la implementacion de las extensiones reactivas  para Dart. Y lo vamos a usar para combinar Streams
import 'dart:convert';

import 'package:paws/src/models/usuario.dart';
import 'package:paws/src/services/db_provider.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  //Aqui vamos a tener dos controladores: uno para la instancia de Usuario y otro para la propiedad autenticando
  final _usuarioController = BehaviorSubject<
      Usuario>(); //Cada que teclemos algo, va a pasar por este StreamController
  final _autenticandoController = BehaviorSubject<
      bool>(); //Cada que teclemos algo, va a pasar por este StreamController

  //Recuperar los datos del Stream
  Stream<Usuario> get usuarioStream => _usuarioController.stream;
  Stream<bool> get autenticandoStream => _autenticandoController.stream;

  //===========================================================================================
  //==================================== METODOS ==============================================

  set autenticando(bool valor) {
    _autenticandoController.sink.add(valor);
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    //Vamos a trabajar el payload que vamos a mandar al backend
    //final data = {'email': email, 'password': password};

    final usuario = await DBProvider.db.getUsuarioByEmail(email);

    // //Ahora vamos a hacer la peticion http, la importamos de 'package:http/http.dart'
    // final resp = await http.post(Uri.parse('${Environment.apiUrl}/login'),
    //     body: jsonEncode(data), headers: {'Content-type': 'application/json'});

    //Ya ha terminado el proceso de autenticacion
    this.autenticando = false;

    //Revisamos el status 200 que significa que todo se hizo bien
    if (usuario != null) {
      if (usuario.password == password) {
        return true;
      } else {
        print("Contraseña incorrecta");
        return false;
      }
    } else {
      print("El usuario no existe");
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;

    //Vamos a trabajar el payload que vamos a mandar al backend
    //final data = {'nombre': nombre, 'email': email, 'password': password};

    final Usuario usuario =
        new Usuario(nombre: nombre, email: email, password: password);

    final nuevo = await DBProvider.db.nuevoUsuario(usuario);

    // //Ahora vamos a hacer la peticion http, la importamos de 'package:http/http.dart'
    // final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/new'),
    //     body: jsonEncode(data), headers: {'Content-type': 'application/json'});

    //Ya ha terminado el proceso de autenticacion
    this.autenticando = false;

    //Revisamos el status 200 que significa que todo se hizo bien
    if (nuevo != -1) {
      // final loginResponse = loginResponseFromJson(resp
      //     .body); //Lo importamos de 'package:chat/models/login_response.dart'
      // //this.usuario = loginResponse.usuario; //Guardamos el modelo. Esta linea era para el Provider clasico
      // _usuarioController.sink.add(loginResponse.usuario); //Guardamos el modelo

      // await this._guardarToken(loginResponse.token);

      return true;
    } else {
      // final respBody = jsonDecode(
      //     resp.body); //Esto es para mapear de un Json String a un mapa
      // return respBody['msg'];
      return false;
    }
  }

  //===========================================================================================
  //===========================================================================================

  dispose() {
    _usuarioController.close(); //Si existe, cierralo
    _autenticandoController.close(); //Si existe, cierralo
  }
}
