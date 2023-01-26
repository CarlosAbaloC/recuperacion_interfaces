

import 'package:flutter/material.dart';

class InputText extends StatelessWidget{
  late final String sInicial;
  late final String sTitulo;
  final ImageIcon imcIzquierda;
  final bool blIsPasswordInput;
  final String sHelperText;

  InputText({Key? key,
    this.sInicial ="",
    this.sTitulo ="",
    this.imcIzquierda=const ImageIcon(AssetImage("assets/images/aprobado.jpg")),
    this.blIsPasswordInput = false,
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
      obscureText: blIsPasswordInput, //No permite ver las palabras
      enableSuggestions: !blIsPasswordInput, //Evita las sugerencias
      autocorrect: !blIsPasswordInput, //Quita el autocorrector
      decoration: InputDecoration(
        labelText: sTitulo,
        labelStyle: TextStyle( color: Color(0xFF6200EE), ),
        helperText: sHelperText,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF6200EE))
        ),
      ),
    );
  }

}