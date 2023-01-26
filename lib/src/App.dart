

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recuperacion_interfaces/src/login_views/LoginView.dart';

import 'login_views/SplashView.dart';

class App extends StatelessWidget{

  const App({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Splash",

      initialRoute: '/splashview',
      routes: {
        '/splashview': (context) => SplashView("assets/images/aprobado.jpg"),
        '/loginview': (context) => LoginView(),
      },
    );
  }
  
}