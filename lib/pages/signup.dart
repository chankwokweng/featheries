import 'package:featheries/components/button.dart';
import 'package:featheries/components/button_icon.dart';
import 'package:featheries/constants.dart';
import 'package:featheries/pages/home.dart';
import 'package:featheries/pages/login.dart';
import 'package:featheries/services/database.dart';
import 'package:featheries/services/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String? name, userId, userPw;

  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController userPwController = TextEditingController();

  final _formkey = GlobalKey <FormState>();
  registration() async{
    if (name!=null && userId!=null && userPw!=null){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                                    email: userId!, password: userPw!);
        //--- generate random ID for new user
        // String id = randomAlphaNumeric(10);
        String id = userCredential.user!.uid;

        //--- save user info locally
        await SharedPreference().saveUserId(id);
        await SharedPreference().saveUserLoginId(userIdController.text);
        await SharedPreference().saveUserName(nameController.text);
        await SharedPreference().saveUserImage(defaultAvatar);
        await SharedPreference().saveUserAdmin(false);

        //--- save user info to Firebase
        Map<String, dynamic> userInfoMap = {
          userInfoMapId       : id,
          userInfoMapName     : nameController.text,
          userInfoMapLoginId  : userIdController.text,
          userInfoMapImage    : defaultAvatar,
          userInfoMapAdmin    : false,
        };
        await DatabaseMethods().addUserDetails(userInfoMap, id);

        //--- navigate to home page
        if (!mounted) return;
        Navigator.push(context,MaterialPageRoute(builder: (context)=> HomePage()));

        //--- Show snack bar message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered Successfully"),));
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

              // gradient: LinearGradient(colors: [Colors.white30, Colors.black45, Colors.black54, Colors.black87, Colors.black])),
            child: Text("Sign Up", style: TextStyle(fontSize: 30, color:Colors.black, fontWeight: FontWeight.bold),),
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
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Name", style: myHeaderTextStyle,),
                  TextFormField(
                    controller: nameController,
                    validator: (value){
                      if (value==null || value.isEmpty){
                        return "Please enter name";
                      }
                      return null;
                    },
              
                    decoration: InputDecoration(hintText: "Name", prefixIcon: Icon(Icons.person_2_outlined)),
                  ),
                  SizedBox(height:40),
                    
                  Text("User ID (email/mobile)", style: myHeaderTextStyle,),
                  TextFormField(
                    controller: userIdController,
                    validator: (value){
                      if (value==null || value.isEmpty){
                        return "Please enter an email address";     //TO DO - support mobile# for sign up
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "email address/mobile#", prefixIcon: Icon(Icons.login_outlined)),
                  ),
                  SizedBox(height:40),
                    
                  //TO DO : To impletment 2 entries of password
                    
                  Text("Password", style: myHeaderTextStyle,),
                  TextFormField(
                    controller: userPwController,
                    validator: (value){
                      if (value==null || value.isEmpty){
                        return "Please enter password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "password", 
                                  prefixIcon: Icon(Icons.password_outlined)),
                    obscureText: true,
                    obscuringCharacter: "*",
                  ),
                  SizedBox(height:40),

                  //--- Sign Up Button
                  GestureDetector(
                    onTap: (){
                      if (_formkey.currentState!.validate()){
                        setState( (){
                          name = nameController.text;
                          userId = userIdController.text;
                          userPw = userPwController.text;
                        },);
                        registration();
                      }
                    },
                    child: MyButton(buttonText: "Sign Up")
                  ),
                    
                    
                  //==== Sign In Instead
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()),);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Already have an account? Log in here", style: mySubHeaderTextStyle,),
                      ],
                    ),
                  ),
                  SizedBox(height:40),
                    
                //==== Sign In with social media
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Text("---------- Or Sign In using the below: ----------", style: mySmallTextStyle,),
                //   ],
                // ),
                // SizedBox(height:10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     MyButtonIcon(buttonText: "Google",    buttonIcon: "assets/icons/google.png"),
                //     MyButtonIcon(buttonText: "Facebook",  buttonIcon: "assets/icons/facebook.png"),
                //   ],
                // ),
              ],),
            ),
          )
        ],)
    );
  }
}