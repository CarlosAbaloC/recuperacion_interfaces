

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget{
  final String sLogoPath;
  const SplashView(this.sLogoPath, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllData();
    //FirebaseAuth.instance.signOut();
  }

  void loadAllData() async{
    //Para cargar las ventanas
    await Future.delayed(Duration(seconds: 2));

    //si no esta logeado
    if(FirebaseAuth.instance.currentUser==null) {
      setState(() {
        Navigator.of(context).popAndPushNamed("/loginview");
      });
    }
    //si esta logeado
    else{

      bool existe = await checkExistingProfile();
      if(existe) {
        setState(() {
          Navigator.of(context).popAndPushNamed("/home");
        });
      } else {
        setState(() {
          Navigator.of(context).popAndPushNamed("/onboardingview");
        });
      }


    }
  }

  Future<bool> checkExistingProfile() async{
    //Consigue la id de tu usuario
    String? idUser=FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("perfil").doc(idUser);

    DocumentSnapshot docsnap= await docRef.get();

    return docsnap.exists;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(widget.sLogoPath)),
              Text("Cargando ...", style: TextStyle(fontSize: 50),),
              const SizedBox(height: 20),
              CircularProgressIndicator(
                semanticsLabel: 'Circular progress indicator',
              ),
            ],
          ),
        ),
      );
    }
}