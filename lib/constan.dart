import 'package:flutter/material.dart';
const kTextBlack = Color(0xFF232323);
const kTextGrey = Color(0xFF939290);
const kOrange = Color(0xFFFE5301);


class TextField_Login extends StatelessWidget {
  TextField_Login(
      {@required this.fildText,
        @required this.TextFieldColor,
        @required this.marginTop,
        @required this.textSEE,
        @required this.onChangeValue,
        @required this.inputType});

  final Color TextFieldColor;
  final String fildText;
  final double marginTop;
  final bool textSEE;
  final Function onChangeValue;

  var inputType;


  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,


      child: TextField(

        textAlign: TextAlign.left,
        onChanged: onChangeValue,
        obscureText: textSEE,
        keyboardType: inputType,
        decoration: InputDecoration(

            fillColor: TextFieldColor,
            filled: true,
            border: OutlineInputBorder(   borderSide:
            BorderSide(color:Colors.red, width: 1.0),borderRadius: BorderRadius.circular(5)),
            hintText: fildText,
            hintStyle: TextStyle(fontSize: 14,color:Color(0xFFD1D1D1),fontWeight: FontWeight.normal)),
      ),
    );
  }
}