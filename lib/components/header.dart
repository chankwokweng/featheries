import 'package:flutter/material.dart';

class MyHeader extends StatelessWidget {
  final double height;
  final String greeting, name, imageURL; 

  const MyHeader({
    super.key, 
    required this.height,
    required this.greeting, 
    required this.name, 
    required this.imageURL
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)) ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 30),
          title: Text(greeting, style: Theme.of(context).textTheme.titleMedium?.copyWith( color: Colors.grey)),
          subtitle: Text(name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color:Colors.white)),
          trailing: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageURL),)
        )
    );
  }
}