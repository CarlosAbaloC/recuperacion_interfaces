import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom_views/ImputText.dart';


class LoginView extends StatelessWidget {

  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar( //Muestra la barra superior
        title: Text("Login"),
      ),
      body: Center( //Alinea el texto al centro
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputText(
            sHelperText: "Nombre de usuario",
            sTitulo: "Usuario",
            ),
            InputText(
              sHelperText: "Contraseña",
              sTitulo: "Contraseña",
              //Cambia el bl de false a true
              blIsPasswordInput: true,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, //Los coloca a distancia
              children: [
                OutlinedButton(
                    onPressed: () {

                      print("------------>>>>>>Registro");
                    },
                    child: Text("Login")
                ),
                OutlinedButton(
                    onPressed: () {

                      print("------------>>>>>>Registro");
                    },
                    child: Text("Registro")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }




}