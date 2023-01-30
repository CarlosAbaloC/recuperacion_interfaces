

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ob_firebase/ListItem.dart';
import '../ob_firebase/Perfil.dart';

class GridItem extends StatefulWidget{
  const GridItem({super.key});



  @override
  State<StatefulWidget> createState() {
    return _GridItemState();
  }
}



class _GridItemState extends State<GridItem> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  String sNombre = "---";
  bool blIsButtonVisible = false;



  //Este metodo busca la ip del usuario y con ella extrae sus datos
  // como nombre ciudad pais y perfil
  actualizarNombre() async {
    //Esto busca un id en concreto, no es dinamico
    //final docRef = db.collection("perfiles").doc("bn6QpIScxrTqA35QR58QYAvtFWA3");
    ListItem();

    String? idUser = FirebaseAuth.instance.currentUser?.uid;
    final docRef = db.collection("perfil").
    doc(idUser).withConverter(fromFirestore: Perfil.fromFirestore,
        toFirestore: (Perfil perfil, _) => perfil.toFirestore());

    final docSnap = await docRef.get();
    final perfilUsuario = docSnap.data(); // Convert to City object

    if (perfilUsuario != null) {
      print(perfilUsuario.nota);
      setState(() {
        sNombre=perfilUsuario.nombre!;
      });
    } else {
      print("No such document.");
    }


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar( //Muestra la barra superior
        title: Text("Chatdar"),
      ),
      //backgroundColor: Colors.white38,
      body: Center( //Alinea el texto al centro
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bienvenido: $sNombre"),

            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed("/formulario");
                },
                child: const Text("Formulario")
            ),

            OutlinedButton(
                onPressed: () {
                  blIsButtonVisible=true;
                  ListItem();
                },
                child: const Text("Agregar otro")
            ),
            OutlinedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).popAndPushNamed("/splashview");
                },
                child: const Text("Logout")
            ),
            if(blIsButtonVisible)OutlinedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).popAndPushNamed("/splashview");
                },
                child: const Text("Logout")
            ),
            if(blIsButtonVisible)OutlinedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).popAndPushNamed("/splashview");
                },
                child: const Text("Logout")
            ),
            MaterialButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.black,
              splashColor: Colors.greenAccent,
              elevation: 8.0,
              onPressed: () { print("---------------->>>>>>>>BOTONIMAGEN"); },
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/aprobado.jpg'),
                        fit: BoxFit.cover)
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Boton"),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }

}