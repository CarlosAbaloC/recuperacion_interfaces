

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        'splashview': (context) => SplashView(),
      },
    );
  }
  
}