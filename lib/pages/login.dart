import 'package:featheries/admin/admin_login.dart';
import 'package:featheries/components/button.dart';
import 'package:featheries/constants.dart';
import 'package:featheries/pages/forgot_password.dart';
import 'package:featheries/pages/home.dart';
import 'package:featheries/pages/signup.dart';
import 'package:featheries/services/database.dart';
import 'package:featheries/services/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? userId, userPw;

  TextEditingController userIdController = TextEditingController();
  TextEditingController userPwController = TextEditingController();

  final _formkey = GlobalKey <FormState>();

  login() async{
    if (userId!=null && userPw!=null){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                                    email: userId!, password: userPw!);
        
        //--- Login successful
        //--- Get user details from database
        // 
        Map userInfoMap = await DatabaseMethods().getUserDetails(userCredential.user!.uid);

        //--- save user info locally
        await SharedPreference().saveUserInfoMap(userInfoMap);


        if (!mounted) return;
        //
        //--- go to home page
        Navigator.push(context,MaterialPageRoute(builder: (context)=> HomePage()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successfully"),));  //TO DO: THIS IS NOT SHOWING
      } on FirebaseAuthException catch (e) {
        String errText = "";
        if (e.code=="weak-password"){
          errText = "Weak password";
        } else if (e.code=="email-already-in-use"){
          errText = "Email already in use";
        } else {
          errText = e.code;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errText),));

      }
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
            child: Text("Log In", style: TextStyle(fontSize: 30, color:Colors.black, fontWeight: FontWeight.bold),),
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
                  
              //=== Login Details
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
                  
                  //--- user password
                  Text("Password", style: myHeaderTextStyle,),
                  TextFormField(
                    controller: userPwController,
                    decoration: InputDecoration(hintText: "password", 
                                  prefixIcon: Icon(Icons.password_outlined)),
                    obscureText: true,
                    obscuringCharacter: "*",
                    validator: (value){
                      if (value==null || value.isEmpty){
                        return "Please enter password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:40),

                  //--- Login
                  GestureDetector(
                    onTap: (){
                      if (_formkey.currentState!.validate()){
                        setState(() {
                          userId = userIdController.text;
                          userPw = userPwController.text;
                        });
                        login();
                      }
                    },
                    child: MyButton(buttonText: "Login")
                  ),
                  
                  //==== Forget Password
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordPage(),));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forget Password? Click here", style: mySubHeaderTextStyle,),
                      ],
                    ),
                  ),
                  SizedBox(height:40),
                  
                  //==== Sign Up
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp(),));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Don't have account? Sign Up here", style: mySubHeaderTextStyle,),
                      ],
                    ),
                  ),
                  SizedBox(height:40),

                  //==== Admin login
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin(),));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Admin login here", style: mySubHeaderTextStyle,),
                      ],
                    ),
                  ),

                ],),
            ),
          )
        ],)
    );
  }
}