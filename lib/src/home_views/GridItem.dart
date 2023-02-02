

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GridItem extends StatelessWidget{
  FirebaseFirestore db = FirebaseFirestore.instance;

  late final String sInicial;
  late final String sTitulo;
  final String sHelperText;


  GridItem({Key? key,
    this.sInicial ="",
    this.sTitulo ="",
    this.sHelperText = "",
  }) : super(key:key);

  final TextEditingController _controller=TextEditingController();


  String getText() {
    return _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: _controller,
      cursorColor: Colors.pink,
      maxLength: 20,
      decoration: InputDecoration(
        labelText: sTitulo,
        labelStyle: TextStyle(color: Color(0xFF6200EE),),
        helperText: sHelperText,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF6200EE))
        ),
      ),
    );
  }
}