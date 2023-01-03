import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/Animations/FadeAnimation.dart';
import 'package:food_recipes/Screens/login.dart';
import 'package:pinput/pinput.dart';
import 'package:food_recipes/Screens/home.dart';


class AuthService{

  var auth = FirebaseAuth.instance;



  signIn(AuthCredential authCredential,context)async{
    try{
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      Navigator.pushNamed(context, MyHome.id);
      // Navigator.pushNamed(context, Interstitial.id);
    }
    catch(e){
    //   Fluttertoast.showToast(
    //       msg: "$e",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
     }

  }
  signInWithOTP(smsCode, verId,BuildContext context) {
    try{
      AuthCredential authCreds = PhoneAuthProvider.credential(
          verificationId: verId, smsCode: smsCode);
      signIn(authCreds,context);}
    catch(e){
      print(e);
    }
  }




  }

