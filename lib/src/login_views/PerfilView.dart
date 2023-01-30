import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recuperacion_interfaces/src/DataHolder.dart';

import '../custom_views/InputText.dart';
import '../ob_firebase/ListItem.dart';
import '../ob_firebase/Perfil.dart';

class PerfilView extends StatefulWidget{
  const PerfilView({super.key});



  @override
  State<StatefulWidget> createState() {
    return _PerfilViewState();
  }
}



class _PerfilViewState extends State<PerfilView> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  String sNombre = "";
  String sCurso = "";
  String sAsign = "";
  String sTrim = "";
  int iNota = 0;
  bool blIsButtonVisible = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataHolder().sMensaje = "Hola desde ONBOARDING"; //Sobreescribe el texto del internal

    actualizarNombre();
  }


  //Este metodo busca la ip del usuario y con ella extrae sus datos
  // como nombre ciudad pais y perfil
  actualizarNombre() async {
    //Esto busca un id en concreto, no es dinamico
    //final docRef = db.collection("perfiles").doc("bn6QpIScxrTqA35QR58QYAvtFWA3");
    ListItem();

    String? idUser = FirebaseAuth.instance.currentUser?.uid;
    final docRef = db.collection("Perfil").
    doc(idUser).withConverter(fromFirestore: Perfil.fromFirestore,
        toFirestore: (Perfil perfil, _) => perfil.toFirestore());

    final docSnap = await docRef.get();
    final perfilUsuario = docSnap.data(); // Convert to City object

    if (perfilUsuario != null) {
      print(perfilUsuario.nota);
      setState(() {
        sNombre=perfilUsuario.nombre!;
        sCurso=perfilUsuario.curso!;
        sAsign=perfilUsuario.asign!;
        sTrim=perfilUsuario.trim!;
        iNota=perfilUsuario.nota!;
      });
    } else {
      sNombre = "NO HAY NOMBRE";
      sCurso = "NO HAY CURSO";
      sAsign = "NO HAY ASIGNATURA";
      sTrim = "NO HAY TRIMESTRE";
      iNota =1000000000;
      print("No such document.");
    }


  }

  InputText inputClase=InputText(
      sHelperText: "Escriba donde quieres introducir el valor",
      sTitulo:"Valor");

  InputText inputDato=InputText(
      sHelperText: "Escribe el dato que quieras introducir",
      sTitulo:"Dato");

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
            Text("Nombre alumno: $sNombre"),
            Text("Año cursado: $sCurso"),
            Text("Asignatura: $sAsign"),
            Text("Trimestre: $sTrim"),
            Text("Nota: $iNota"),


            inputClase,
            inputDato,
            FloatingActionButton(onPressed: acceptPressed(inputNombre.getText(),inputCurso.getText(),
                inputTrim.getText(), inputAsign.getText(),
                int.parse(inputNota.getText()),context);)

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
                  child: Text("Boton", style: TextStyle(color: Colors.green),),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }

}