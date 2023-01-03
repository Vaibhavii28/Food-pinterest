import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/Animations/FadeAnimation.dart';
import 'package:food_recipes/Screens/allRecipes.dart';
import 'package:food_recipes/Screens/login.dart';
import 'package:food_recipes/Screens/otp.dart';
import 'package:food_recipes/Screens/home.dart';
import 'package:food_recipes/Screens/details.dart';
import 'package:food_recipes/Screens/savedlist.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD7rI9G3YLQrYtNaLJLavPa5NHK-TX3Ua0",
            appId: "1:410295791825:web:d9586d816d871028c915f0",
            messagingSenderId: "410295791825",
            projectId: "food-pinterest"));
  }
  else {
    await Firebase.initializeApp(
        //name: 'food-pinterest',
        options: FirebaseOptions(
            apiKey: "AIzaSyD7rI9G3YLQrYtNaLJLavPa5NHK-TX3Ua0",
            appId: "1:410295791825:web:d9586d816d871028c915f0",
            messagingSenderId: "410295791825",
            projectId: "food-pinterest"));
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: MyLogin.id,
    routes: {
      MyLogin.id:(context) => MyLogin(),
      MyOtp.id: (context) => MyOtp(""),
      MyHome.id: (context) => MyHome(),
      MyDetails.id: (context)=> MyDetails(0, RecipeObject(name: 'name',  image: 'image', time: 'time', servings: 'servings', id: 'id', instructions: 'instructions', priceperserving: 'priceperserving', ), false,),
      MySaved.id: (context)=> MySaved(0, RecipeObject(name: 'name',  image: 'image', time: 'time', servings: 'servings', id: 'id', instructions: 'instructions', priceperserving: 'priceperserving', ), false, ),
      MyAllRecipes.id: (context)=> MyAllRecipes()
    },
  ));
}
