//======================================================================
//ESTE MODELO SE GENERO EN quicktype.io
//======================================================================

// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.id,
    required this.nombre,
    required this.email,
    required this.password,
  });

  int? id;
  String nombre;
  String email;
  String password;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "email": email,
        "password": password,
      };
}
