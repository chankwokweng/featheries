import 'package:featheries/admin/booking_admin.dart';
import 'package:featheries/components/button.dart';
import 'package:featheries/constants.dart';
import 'package:featheries/pages/login.dart';
import 'package:featheries/services/database.dart';
import 'package:featheries/services/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  
  TextEditingController adminNameController = TextEditingController();
  TextEditingController adminPwController = TextEditingController();

  adminLogin() async{
      try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                                  email: adminNameController.text, password: adminPwController.text);
      
      //--- Login successful
      //--- Get user details from database
      // 
      Map userInfoMap = await DatabaseMethods().getUserDetails(userCredential.user!.uid);

      //--- Check if user is part of admin group (YES)
      if (userInfoMap[userInfoMapAdmin]) {
        //--- save user info locally
        await SharedPreference().saveUserInfoMap(userInfoMap);

        if (!mounted) return;
        //
        //--- go to home page
        Navigator.push(context,MaterialPageRoute(builder: (context)=> BookingAdmin()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successfully"),));  //TO DO: THIS IS NOT SHOWING
      } else {
        // Not admin
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You are not administrator"),));  //TO DO: THIS IS NOT SHOWING
      }
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

              // gradient: LinearGradient(colors: [Colors.white30, Colors.black45, Colors.black54, Colors.black87, Colors.black])),
            child: Text("Admin Panel", style: TextStyle(fontSize: 30, color:Colors.black, fontWeight: FontWeight.bold),),
          ),
          
          //--- Form for Sign UP
          Container(            
            margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/6),
            padding: EdgeInsets.only(top:40, left:20, right:20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white, 
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      
            //=== Sign Up Details
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    
                  Text("Admin Name)", style: myHeaderTextStyle,),
                  TextFormField(
                    controller: adminNameController,
                    decoration: InputDecoration(hintText: "Admin Name", prefixIcon: Icon(Icons.login_outlined)),
                  ),
                  SizedBox(height:40),
                    
                  //TO DO : To impletment 2 entries of password
                    
                  Text("Password", style: myHeaderTextStyle,),
                  TextFormField(
                    controller: adminPwController,
                    decoration: InputDecoration(hintText: "password", 
                                  prefixIcon: Icon(Icons.password_outlined)),
                    obscureText: true,
                    obscuringCharacter: "*",
                  ),
                  SizedBox(height:40),

                  //--- Sign Up Button
                  GestureDetector(
                    onTap: (){
                      adminLogin();
                    },
                    child: MyButton(buttonText: "LOGIN")
                  ),
                  SizedBox(height:40),

                  //==== Go to normal login
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn(),));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("User login here", style: mySubHeaderTextStyle,),
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