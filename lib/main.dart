import 'dart:io';

import 'package:featheries/firebase_options.dart';
import 'package:featheries/pages/login.dart';
import 'package:featheries/services/shared_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await SharedPreference().clearUserInfo();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    stderr.writeln("Error in initializing Firebase : $e.code");
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "where featheries have fun & gain health",
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        primarySwatch: Colors.indigo),
      home: Scaffold(
        body: LogIn(),
        // Center(
        //   child: 
        //     Column(
        //       children: [
        //         // Image.asset("assets/google.png"),
        //         // Image.asset("assets/icons/facebook.png"),
        //         // const Text('Hello World!'),
        //         // MyHeader(height: 100, greeting: "Hello", name: "John Tan", imageURL: defaultAvatar),
        //         ,
        //       ],
        //     ),
        // ),
      ),
    );
  }
}
