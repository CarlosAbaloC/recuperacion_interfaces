




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_views/InputText.dart';

class LoginView extends StatelessWidget {

  const LoginView({Key? key}) : super(key: key);

  void loginPressed(String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      Navigator.of(context).popAndPushNamed('/splashview');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    InputText user = InputText(
      sHelperText: "Nombre de usuario",
      sTitulo: "Usuario",
    );
    InputText password = InputText(
      sHelperText: "Contraseña",
      sTitulo: "Contraseña",
      //Cambia el bl de false a true
      blIsPasswordInput: true,
    );

    return Scaffold(
      appBar: AppBar( //Muestra la barra superior
        title: Text("Login"),
      ),
      body: Center( //Alinea el texto al centro
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user,
            password,


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