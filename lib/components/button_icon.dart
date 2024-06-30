// import 'package:appointment/constants.dart';
import 'package:flutter/material.dart';

class MyButtonIcon extends StatelessWidget {

  final String buttonText; 
  final String buttonIcon;

  const MyButtonIcon({super.key, required this.buttonText, required this.buttonIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:50,
      width:150,
      padding: const EdgeInsets.symmetric(horizontal:10, vertical:10),
      decoration: BoxDecoration(color: Colors.white, 
        border: Border.all(color:Colors.blue),
        borderRadius: BorderRadius.circular(5), 
        shape:BoxShape.rectangle),
      // width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset( buttonIcon, width:25, height:25, fit:BoxFit.fitWidth ),
          const SizedBox(width:10),
          Text( buttonText, style:const TextStyle(
                                        color:Color.fromARGB(248, 207, 207, 68),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
        ],
      )
    );
  }
}
