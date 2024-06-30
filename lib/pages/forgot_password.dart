import 'package:featheries/components/button.dart';
import 'package:featheries/constants.dart';
import 'package:featheries/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  TextEditingController userIdController = TextEditingController();

  final _formkey = GlobalKey <FormState>();

  resetPassword() async {
    String ? userId;

    try {
      userId = userIdController.text;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: userId);
      if (!mounted) return;
      //
      //--- go to home page
      Navigator.push(context,MaterialPageRoute(builder: (context)=> LogIn()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Reset password email sent!"),));
    } on FirebaseAuthException catch (e) {
      String errText = e.code;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errText),));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          //--- Header Panel
          Container(
            padding: EdgeInsets.only(top:80, left:30),
            height:MediaQuery.of(context).size.height/2,
            width:MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [colorScheme.surface, colorScheme.secondary])),
            child: Text("Password Recovery", style: TextStyle(fontSize: 30, color:Colors.black, fontWeight: FontWeight.bold),),
          ),

          //--- Login Panel
          Form(
            key: _formkey,
            child: Container(
              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/6),
              padding: EdgeInsets.only(top:80, left:20, right:20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
                  
              //=== Login Id
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //--- user Id
                  Text("User ID (email/mobile)", style: myHeaderTextStyle,),
                  TextFormField(
                    controller: userIdController,
                    decoration: InputDecoration(hintText: "email address/mobile#", prefixIcon: Icon(Icons.login_outlined)),
                    validator: (value){
                      if (value==null || value.isEmpty){
                        return "Please enter email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:40),
                  
                  //--- Login
                  GestureDetector(
                    onTap: () async {
                      if (_formkey.currentState!.validate()){
                        setState(() {
                        });
                        await resetPassword();
                      }
                    },
                    child: MyButton(buttonText: "Password Reset")
                  ),
                  
                  //==== Forget Password
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn(),));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Try to login again", style: mySubHeaderTextStyle,),
                      ],
                    ),
                  ),
                  SizedBox(height:40),
                ],),
            ),
          )
        ],)
    );
  }
}