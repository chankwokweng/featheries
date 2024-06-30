import 'package:featheries/constants.dart';
import 'package:flutter/material.dart';


class MyServiceCard extends StatelessWidget {
  
  final String serviceImage;
  final String serviceText;

  const MyServiceCard({
    super.key,
    required this.serviceImage,
    required this.serviceText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Booking (service: serviceText)));
      },
      child: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(serviceImage, height:150, width:150, fit:BoxFit.cover)
                      ),
                      Text(serviceText, style:mySubHeaderTextStyle),
                    ],),
    );

  }
}


