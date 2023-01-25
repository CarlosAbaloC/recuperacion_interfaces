

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
    //FirebaseAuth.instance.signOut();
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