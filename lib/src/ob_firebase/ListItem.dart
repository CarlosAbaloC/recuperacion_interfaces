

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Perfil.dart';

class ListItem extends StatelessWidget{

  late final String sNombre;
  late final String sCurso;
  late final String sAsign;
  late final String sTrim;
  late final int iNota;



  ListItem({Key? key,
    this.sNombre = "Vacio",
    this.sCurso= "Vacio",
    this.sAsign= "Vacio",
    this.sTrim= "Vacio",
    this.iNota=  0,

  }) : super(key:key);


  final TextEditingController _controller=TextEditingController();


  String getText() {
    return _controller.text;
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  String sName = "---";
  bool blIsButtonVisible = true;


  informacionPerfil() async {

    String? idUser = FirebaseAuth.instance.currentUser?.uid;
    final docRef = db.collection("perfil").
    doc(idUser).withConverter(fromFirestore: Perfil.fromFirestore,
        toFirestore: (Perfil perfil, _) => perfil.toFirestore());

    final docSnap = await docRef.get();
    final perfilUsuario = docSnap.data(); // Convert to City object

    if (perfilUsuario != null) {
      this.sNombre = perfilUsuario.nombre!;
      this.sCurso = perfilUsuario.curso!;
      this.sAsign = perfilUsuario.asign!;
      this.sTrim = perfilUsuario.trim!;
      this.iNota = perfilUsuario.nota!;

    } else {
      print("No such document.");
    }


  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return TextFormField(
      controller: _controller,
      cursorColor: Colors.pink,
      //initialValue: this.sValorInicial, //no puedes poner controller y initialvalue a la vez
      //El bl ahora esta en false, por lo que permite ver las palabras y el autocorrector
      //En cambio cuando sea una contraseña cambian las tornas true como false false como true
      decoration: InputDecoration(
        labelText: sNombre,
        labelStyle: TextStyle(
          color: Color(0xFF6200EE),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF6200EE))
        ),
      ),
    );
  }

}