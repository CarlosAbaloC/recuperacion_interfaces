import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recuperacion_interfaces/src/singleton/DataHolder.dart';
import 'package:recuperacion_interfaces/src/home_views/GridItem.dart';

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

  late List<Perfil> perfilText = [];

  List<String> datos =["NOMBRE", "CURSO", "ASIGNATURA", "TRIMESTRE", "NOTA"];

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


  void descargarTextos() async {

    //HACER UN ARRAY CON DATOS MANUAL DETRAS DE LOS DATOS YA ESTABLECIDOS Y ASI PODER VER TODOS LOS DATOS SIN NECESIDAD DE HACERLO POR PARTES

    /*
    String path = DataHolder().perfil.uid+"/"+
        DataHolder().sCollection_Perfil_Name; //Coge la id desde room y la pone, asi se cambia si es una u otra

    final docRef = db.collection(path).//orderBy("time").limit(50). Una manera de ordenarse
    withConverter(fromFirestore: Perfil.fromFirestore,  //Para descargarse todos los archivos de rooms, por eso no usa ids ni nada
        toFirestore: (Perfil fbtext, _) => fbtext.toFirestore());

    docRef.snapshots().listen(
          (event) => {
        setState(() {
          for(int i=0; i<event.docs.length; i++) {
            perfilText.add(event.docs[i].data());
          }
        })
      },
      onError: (error) => print("Listen failed: $error"),
    );

     */

    setState(() {
      for(int i=0; i<datos.length; i++) {
        datos.add(datos[i]);

      }
    },);
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

  GridItem inputNombre = GridItem(

  );


  GridItem inputClase=GridItem(
      sHelperText: "Escriba donde quieres introducir el valor",
      sTitulo:"Valor");

  GridItem inputDato=GridItem(
      sHelperText: "Escribe el dato que quieras introducir",
      sTitulo:"Dato");

  void acceptPressed(String nombre, String curso,  BuildContext context) async{
    Perfil perfil = Perfil(nombre: nombre, curso: curso);

    await db.collection("Perfil").doc(FirebaseAuth.instance.currentUser?.uid).set(perfil.toFirestore())
        .onError((e, _) => print("Error writing document: $e"));

    Navigator.of(context).popAndPushNamed("/perfilview");
  }

  @override
  Widget build(BuildContext context) {

    final List<String> entries = <String>['A','B','C','D','E'];
    final List<int> colorCodes = <int>[600, 500,100,400,300];
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
            FloatingActionButton(onPressed: () {
              acceptPressed(inputClase.getText(),inputDato.getText(),context);
            },),

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

            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed('/nuevoregistroview');
                  print("------------>>>>>>Registro");
                },
                child: Text("Añade informacion")
            ),
          ],
        ),
      ),
    );
  }

}