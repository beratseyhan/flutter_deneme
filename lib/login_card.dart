import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  LoginCard({@required this.colour, this.cardChild, this.onPress});

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.symmetric(horizontal :MediaQuery.of(context).size.width * 0.025,vertical:  MediaQuery.of(context).size.height * 0.01,),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
