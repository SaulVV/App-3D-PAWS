import 'dart:async';

class Validators {
  //<String, String> : indica que la entrada va a ser un String y la salida tambien va a ser un String
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
      //importamos StreamTransformer de 'dart:async'

      handleData: (email, sink) {
    //sink le va a decir al StreamTransformer cual informacion sigue fluyendo o que informacion necesito notificar que hay un error y bloquearlo

    //Patron para validar un correo electronico
    final pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    //Definimos la expresion regular
    RegExp regExp = new RegExp(pattern);

    //Validacion
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('El email no es correcto');
    }
  });

  //Validamos que la contraseña contenga al menos 6 caracteres
  //<String, String> : indica que la entrada va a ser un String y la salida tambien va a ser un String
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      //importamos StreamTransformer de 'dart:async'

      handleData: (password, sink) {
    //sink le va a decir al StreamTransformer cual informacion sigue fluyendo o que informacion necesito notificar que hay un error y bloquearlo
    //Validacion
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Debe contener al menos 6 caracteres');
    }
  });

  //Validamos que el nombre para que tenga más de un caracter
  //<String, String> : indica que la entrada va a ser un String y la salida tambien va a ser un String
  final validarName = StreamTransformer<String, String>.fromHandlers(
      //importamos StreamTransformer de 'dart:async'

      handleData: (name, sink) {
    //sink le va a decir al StreamTransformer cual informacion sigue fluyendo o que informacion necesito notificar que hay un error y bloquearlo
    //Validacion
    if (name.length > 0) {
      sink.add(name);
    } else {
      sink.addError('Debe ingresar un nombre');
    }
  });
}
