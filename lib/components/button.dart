import 'package:featheries/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final String buttonText; 
  const MyButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:20, vertical:20),
      decoration: myButtonBoxDecoration,
      // width: MediaQuery.of(context).size.width,
      child: Text( buttonText, style:myButtonTextStyle)
    );
  }
}
