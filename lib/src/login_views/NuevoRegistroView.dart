
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recuperacion_interfaces/src/ob_firebase/NuevoDato.dart';

import '../custom_views/InputText.dart';
import '../home_views/GridItem.dart';

class NuevoRegistroView extends StatefulWidget{
  const NuevoRegistroView({Key? key}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NuevoRegistroViewState();
  }
}

class _NuevoRegistroViewState extends State<NuevoRegistroView>{
  FirebaseFirestore db=FirebaseFirestore.instance;

  void checkExistingProfile() async{
    //Consigue la id de tu usuario
    String? idUser=FirebaseAuth.instance.currentUser?.uid;
    final docRef = db.collection("Informacion").doc(idUser);

    DocumentSnapshot docsnap= await docRef.get();
  }

  void acceptPressed(String nombre, String curso, BuildContext context) async{
    NuevoDato dato = NuevoDato(nombre: nombre, curso: curso);

    await db.collection("Perfil").doc(FirebaseAuth.instance.currentUser?.uid).set(dato.toFirestore())
        .onError((e, _) => print("Error writing document: $e"));

    Navigator.of(context).popAndPushNamed("/perfilview");
  }

  @override
  Widget build(BuildContext context) {
    GridItem inputClase=GridItem(
        sHelperText: "Escriba donde quieres introducir el valor",
        sTitulo:"Valor");

    GridItem inputDato=GridItem(
        sHelperText: "Escribe el dato que quieras introducir",
        sTitulo:"Dato");


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
            inputClase,
            inputDato,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {

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