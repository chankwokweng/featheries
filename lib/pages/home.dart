// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:featheries/components/button_icon.dart';
import 'package:featheries/components/services.dart';
import 'package:featheries/constants.dart';
import 'package:featheries/services/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String? name, image;

  //--- get the data from Shared Preference

  getthedatafromsharedpref() async{
    name = "default name";
    image = "";

    name = await SharedPreference().getUserName();
    image = await SharedPreference().getUserImage();
    setState( ()=> {
    });
  }

  getontheload() async{
    await getthedatafromsharedpref();
    setState( ()=> {
    });
  }

  //--- Logout
  logout() async {
    await FirebaseAuth.instance.signOut();
    await FirebaseFirestore.instance.terminate();
    if (!mounted) return;
    // Navigator.push(context,MaterialPageRoute(builder: (context)=> LogIn()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logout Successfully"),));  //TO DO: THIS IS NOT SHOWING
  }
  
  
  @override
  void initState(){
    getontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
          margin: const EdgeInsets.only(top:60, left:20, right:20),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Hello,", style:myHeaderTextStyle),
                      Text(name!, style:myHeaderTextStyle),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: (image!.isEmpty)? Image.asset("images/default.png"):Image.network(image!, height:60, width:60, fit:BoxFit.cover)
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                        await logout();
                    },
                    child: const SizedBox(
                      height: 60,
                      width: 60,
                      child: MyButtonIcon(
                        buttonText: "",
                        buttonIcon: "images/logout.png",
                      ),
                    ),
                  ),
              ],),
              const SizedBox(height:20),
              const Divider( thickness: 1, color: myDividerColor, ),
              const SizedBox(height:20),
              const Text("Services", style:myHeaderTextStyle),
              const SizedBox(height:10),

              // Services ===========================
              const SizedBox(
                height: 200,
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyServiceCard(serviceImage:"images/makeup.jpeg", serviceText:"Make Up"),
                    MyServiceCard(serviceImage:"images/haircut.jpeg", serviceText:"Hair Cut"),
                  ],),
              ),
              const SizedBox(
                height: 200,
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyServiceCard(serviceImage:"images/manicure.jpeg", serviceText:"Manicure"),
                    MyServiceCard(serviceImage:"images/hairgrowth.jpeg", serviceText:"Hair Growth"),
                  ],),
              ),
              const SizedBox(
                height: 200,
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyServiceCard(serviceImage:"images/washhair.jpeg", serviceText:"Hair Wash"),
                    MyServiceCard(serviceImage:"images/coloring.jpeg", serviceText:"Hair Coloring"),
                  ],),
              ),


          ],
        ),
      ),);
  }
}