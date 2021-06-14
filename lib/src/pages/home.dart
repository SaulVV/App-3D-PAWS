import 'package:flutter/material.dart';
import 'package:paws/src/services/enviar.dart';
import 'package:paws/src/services/recibir.dart';
import 'package:paws/src/widgets/boton.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("3D-PAWS App"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Boton(
              titulo: "Enviar",
              icono: Icons.send_to_mobile,
              funcion: enviarDatos,
            ),
            Boton(
              titulo: "Recibir",
              icono: Icons.get_app,
              funcion: recibirDatos,
            ),
          ],
        ),
      ),
    );
  }
}
