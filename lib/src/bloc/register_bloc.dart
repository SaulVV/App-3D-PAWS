import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:paws/src/bloc/validators.dart';

//RXDart es la implementacion de las extensiones reactivas  para Dart. Y lo vamos a usar para combinar Streams

class RegisterBloc with Validators {
  //Aqui vamos a tener dos controladores: uno para el email y otro para el password
  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<
      String>(); //Cada que teclemos algo, va a pasar por este StreamController
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get nameStream =>
      _nameController.stream.transform(validarName);
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  //Vamos a validar los Streams para habilitar o deshabilitar el boton
  Stream<bool> get registerValidStream => Rx.combineLatest3(
      nameStream, emailStream, passwordStream, (e, p, n) => true);

  //Insertar valores al Stream
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener el ultimo valor ingresado a los Streams
  String get name => _nameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _nameController
        .close(); //Colocando '?' nos aseguramos de cerrarlo solo si existe
    _emailController
        .close(); //Colocando '?' nos aseguramos de cerrarlo solo si existe
    _passwordController
        .close(); //Colocando '?' nos aseguramos de cerrarlo solo si existe
  }
}
