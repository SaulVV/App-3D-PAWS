import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final titulo;
  final icono;
  final funcion;

  const Boton({this.titulo, this.icono, this.funcion});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        icono,
        size: 40,
      ),
      label: Text(
        titulo,
        style: TextStyle(fontSize: 30),
      ),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        side: BorderSide(color: Colors.black, width: 1),
        minimumSize: Size(300, 200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: funcion,
    );
  }
}
