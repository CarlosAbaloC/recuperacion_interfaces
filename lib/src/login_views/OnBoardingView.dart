import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_views/InputText.dart';
import '../ob_firebase/Perfil.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OnBoardingViewState();
  }
}

class _OnBoardingViewState extends State<OnBoardingView>{
  FirebaseFirestore db=FirebaseFirestore.instance;

  void checkExistingProfile() async{
    //Consigue la id de tu usuario
    String? idUser=FirebaseAuth.instance.currentUser?.uid;
    final docRef = db.collection("Perfil").doc(idUser);

    DocumentSnapshot docsnap= await docRef.get();

    if(docsnap.exists){
      Navigator.of(context).popAndPushNamed("/home");
    }
    //DataHolder().pruebaFuncion();
  }

  void acceptPressed(String nombre, String curso, String trim, String asign, int nota, BuildContext context) async{
    Perfil perfil = Perfil(nombre: nombre, curso: curso, trim: trim, asign: asign, nota: nota);

    await db.collection("Perfil").doc(FirebaseAuth.instance.currentUser?.uid).set(perfil.toFirestore())
        .onError((e, _) => print("Error writing document: $e"));

    Navigator.of(context).popAndPushNamed("/splashview");
  }

  @override
  Widget build(BuildContext context) {
    InputText inputNombre=InputText(
        sHelperText: "Escriba su Nombre",
        sTitulo:"Nombre");

    InputText inputCurso=InputText(
        sHelperText: "Escriba su Curso",
        sTitulo:"Curso");

    InputText inputTrim=InputText(
        sHelperText: "Escriba el trimestre",
        sTitulo:"Trimestre");

    InputText inputAsign=InputText(
        sHelperText: "Escriba asignatura",
        sTitulo:"Asignatura");

    InputText inputNota=InputText(
        sHelperText: "Escriba su nota",
        sTitulo:"Nota");


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('On Boarding'),
      ),
      //backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputNombre,
            inputCurso,
            inputTrim,
            inputAsign,
            inputNota,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    acceptPressed(inputNombre.getText(),inputCurso.getText(),
                        inputTrim.getText(), inputAsign.getText(),
                        int.parse(inputNota.getText()),context);
                  },
                  child: Text("Aceptar"),
                ),
                OutlinedButton(
                  onPressed: () {

                  },
                  child: Text("Cancelar"),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
  
  
}