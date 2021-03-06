import 'package:flutter/material.dart';
import 'package:paws/src/bloc/provider.dart';
import 'package:paws/src/services/usuario_provider.dart';
import 'package:paws/src/utils/utils.dart';
import 'package:paws/src/widgets/labels.dart';

class LoginPage extends StatelessWidget {
  //final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);
    final authBloc = Provider.authBloc(context);

    //Inicializamos el valor de autenticando
    authBloc.autenticando = false;

    return SingleChildScrollView(
      //SingleChildScrollView es un elemento que me va a permitir scroll, para evitar que el teclado oculte el log in
      child: Column(
        children: [
          SafeArea(
              //Este me calcula la distancia al notch y toma distancia con la parte alta
              child: Container(
            height: 180.0,
          )),
          Container(
            //No especificamos la altura porque queremos que se ajuste al contenido
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0,
                  ),
                ]),
            child: Column(
              children: [
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearBoton(bloc, authBloc, context),
              ],
            ),
          ),
          Labels(
              ruta: 'register',
              titulo: '??No tienes una cuenta?',
              subtitulo: 'CREAR UNA CUENTA'),
          /*
          TextButton(
            child: Text('Crear una nueva cuenta'),
            onPressed: (){},
            //onPressed: () => Navigator.pushReplacementNamed(context, 'registro'),
          ),
          */
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.redAccent),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electr??nico',
              //counterText: snapshot.data,
              errorText: "${snapshot.error}",
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.redAccent),
              labelText: 'Contrase??a',
              //counterText: snapshot.data, //si hay un error de validacion la data viene el null
              errorText: "${snapshot.error}",
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc, AuthBloc authBloc, BuildContext context) {
    //final authService = PROVIDER.Provider.of<AuthService>(context);
    return StreamBuilder(
      //Este StreamBuilder es para validar el formulario
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshotForm) {
        return StreamBuilder(
          stream: authBloc.autenticandoStream,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot snapshotAuth) {
            return ElevatedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                child: Text('Ingresar'),
              ),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.redAccent,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                elevation: 0.0,
              ),
              onPressed: (snapshotForm.hasData &
                      (!snapshotAuth
                          .data)) //"Si tiene data y no esta autenticando"
                  ? () => _login(bloc, authBloc, context) //Si tiene datos
                  : null, //Si no tiene datos
            );
          },
        );
      },
    );
  }

  _login(LoginBloc bloc, AuthBloc authBloc, BuildContext context) async {
    //print('=========================');
    //print('Email : ${ bloc.email }');
    //print('Password : ${ bloc.password }');
    //print('=========================');

    //final authService = PROVIDER.Provider.of<AuthService>(context, listen: false);

    //Quitamos el teclado
    FocusScope.of(context).unfocus();

    final loginOk =
        await authBloc.login(bloc.email.trim(), bloc.password.trim());

    if (loginOk) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      mostrarAlerta(
          context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
    }

    /*
    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if( info['ok'] ){
      Navigator.pushReplacementNamed(context, '/');
    } else{
      mostrarAlerta( context, 'AVISO', info['mensaje'] );
    }
    */
    //Navigator.pushReplacementNamed(context, 'home');
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Colors.redAccent,
          Colors.white,
        ]),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.1)),
    );

    return Stack(
      children: [
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          //padding: EdgeInsets.only(top: 5.0),
          child: Image(
            image: AssetImage('assets/logo.png'),
          ),
        ),
      ],
    );
  }
}
