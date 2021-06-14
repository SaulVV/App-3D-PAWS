//Este va a ser mi inheritedWidget personalizado

//=======================================================================================
/*
PASOS PARA AGREGAR OTRO BLOC:
  PASO 1 :  Importa y exprotar la clase del bloc
  PASO 2 : Crea la instancia correspondiente
  PASO 3 : Crear la funcion que busque dentro del arbol de Widgets
*/
//El resto es la configuracion enecesaria para crear un provider instanciando al InheritedWidget
//=======================================================================================

import 'package:flutter/material.dart';

//PASO 1
import 'package:paws/src/bloc/login_bloc.dart';
//Y lo exportamos, para que donde sea que tenga explicito la clase Provider, ya venga implicito el LoginBloc
export 'package:paws/src/bloc/login_bloc.dart';

import 'package:paws/src/bloc/register_bloc.dart';
export 'package:paws/src/bloc/register_bloc.dart';

import 'package:paws/src/bloc/auth_bloc.dart';
export 'package:paws/src/bloc/auth_bloc.dart';
//------------------------------------------------------------

class Provider extends InheritedWidget {
  static Provider? _instancia;

  factory Provider({Key? key, required Widget child}) {
    if (_instancia == null) {
      _instancia = Provider._internal(
        key: key,
        child: child,
      );
    }
    return _instancia!;
  }

  Provider._internal({Key? key, required child})
      : super(key: key, child: child);

  //PASO 2
  final loginBloc =
      new LoginBloc(); //Aqui estamos creando la unica instancia que vamos a crear de LoginBloc
  //PASO 2
  //final _productosBloc = new ProductosBloc(); //Este lo vamos a trabajar como privado, pero es lo mismo.
  final _registerBloc = new RegisterBloc();
  final _authBloc = new AuthBloc();

  //Provider({Key key, Widget child})
  //  : super( key : key, child: child );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      true; //Indicamos que cuando se haga una modificacion, SIEMPRE notifique a los hijos

  //PASO 3
  //Esta funcion va a buscar internamente dentro del arbol de Widgets (dentro de context) y va a retornar la instancia de la instancia loginBlock
  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBloc;
  }

  //PASO 3
  //Ahora lo mismo para ProductosBloc
  //Esta funcion va a buscar internamente dentro del arbol de Widgets (dentro de context) y va a retornar la instancia de la instancia _productosBlock
  //static ProductosBloc productosBloc ( BuildContext context ){
  //    return context.dependOnInheritedWidgetOfExactType<Provider>()._productosBloc;
  //}
  //Esta funcion va a buscar internamente dentro del arbol de Widgets (dentro de context) y va a retornar la instancia de la instancia loginBlock

  //Esta funcion va a buscar internamente dentro del arbol de Widgets (dentro de context) y va a retornar la instancia de la instancia authBlock
  static RegisterBloc registerBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()!
        ._registerBloc;
  }

  //Esta funcion va a buscar internamente dentro del arbol de Widgets (dentro de context) y va a retornar la instancia de la instancia authBlock
  static AuthBloc authBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!._authBloc;
  }
}
