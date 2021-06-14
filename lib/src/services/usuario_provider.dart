// import 'dart:convert';

// //import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
// import 'package:http/http.dart' as http;

// class UsuarioProvider {
//   /*
//   1. Hay que habilitar la autenticacion por email y contraseña.

//   2. Para poder hacer la peticion al servidio de Firebase se necesita un URL en paticular
//   y es el que me permite mandar a llamar el registro y el login.
//   Se ontene de aqui el Endpoint
//     https://firebase.google.com/docs/reference/rest/auth#section-create-email-password
//   Aqui lo llamamos en http.post()

//   3. El [API_KEY] aparece en Firebase en 'Configuracion del proyecto' como ´Clave de API web', aqui lo definimos como _firebaseToken
//   */

//   final String _firebaseToken = 'AIzaSyBKTgghJlSuD9lSf-DTeSgcGR2927pC56c';
//   //final _prefs = new PreferenciasUsuario();

//   Future<Map<String, dynamic>> login(String email, String password) async {
//     final authData = {
//       'email': email,
//       'password': password,
//       'returnSecureToken': true //Me interesa recibir este token
//     };

//     //El URL que se necesita llamar
//     final resp = await http.post(
//       //Importamos http de 'package:http/http.dart'
//       Uri.parse(
//           'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken'),
//       body: json.encode(authData), //Importamos json de 'dart:convert'
//     );

//     Map<String, dynamic> decodeResp = json.decode(resp.body);

//     print(decodeResp);

//     if (decodeResp.containsKey('idToken')) {
//       //El correo y contraseña provehida son validos
//       //Guardamos el token en las preferencias de usuario (storage)
//       //_prefs.token = decodeResp['idToken'];
//       return {'ok': true, 'token': decodeResp['idToken']};
//     } else {
//       return {'ok': false, 'mensaje': decodeResp['error']['message']};
//     }
//   }

//   Future<Map<String, dynamic>> nuevoUsuario(
//       String email, String password) async {
//     final authData = {
//       'email': email,
//       'password': password,
//       'returnSecureToken': true //Me interesa recibir este token
//     };

//     //El URL que se necesita llamar
//     final resp = await http.post(
//       //Importamos http de 'package:http/http.dart'
//       Uri.parse(
//           'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
//       body: json.encode(authData), //Importamos json de 'dart:convert'
//     );

//     Map<String, dynamic> decodeResp = json.decode(resp.body);

//     print(decodeResp);

//     if (decodeResp.containsKey('idToken')) {
//       //El correo y contraseña provehida son validos
//       //Guardamos el token en las preferencias de usuario (storage)
//       //_prefs.token = decodeResp['idToken'];
//       return {'ok': true, 'token': decodeResp['idToken']};
//     } else {
//       return {'ok': false, 'mensaje': decodeResp['error']['message']};
//     }
//   }
// }
