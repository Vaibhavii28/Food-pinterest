import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipes/Screens/savedlist.dart';

import '../Services/Recipes.dart';
import '../Services/firebase.dart';
import 'constants.dart';
import 'details.dart';
import 'home.dart';
class MyAllRecipes extends StatefulWidget {
  static const String id = 'allrecipes_screen';

  @override
  State<MyAllRecipes> createState() => _MyAllRecipesState();
}

class _MyAllRecipesState extends State<MyAllRecipes> {
  bool gotdata = false;
  bool tag = false;
  int multiplier= 1;
  
  List<RecipeObject> listofobj2 = [];
  @override

    // TODO: implement initState
    void getData() async {
      listofobj2 = await NetworkHelper().getRandomRecipe2();
      for(var obj in listofobj2)
      {

        obj.calories= await NetworkHelper().getNutriData(obj.id);
        print(listofobj2);
      }
      setState(() {
        gotdata = true;
      });
    }

    @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  var firestore=FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightColor,
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
            height: 58.0,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
              gradient: kGradient,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0)),
            ),
            child: Text(
              "Back",
              style: TextStyle(
                  fontSize: 24.0,
                  color: kLightColor,
                  fontWeight: FontWeight.bold),
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 64.0, left: 14.0, right: 14.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "More recommended recipes",
                    style: TextStyle(fontSize: 36.0, color: kDarkcolor),
                  ),
                ),
              ),
              gotdata? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10*multiplier ,
                padding: EdgeInsets.zero,
                reverse: true,
                itemBuilder: (context, index) {

                  return RecipeCard(recobjj: listofobj2[index]);

                },
              ) :Container(child: Center(child: CircularProgressIndicator())),
        gotdata? TextButton(onPressed: (){
          getData();
          setState(() {
            if(multiplier<3)
            {
              multiplier++;
            }

          });
        }, child: Text('Load more', style: TextStyle(color: kPrimaryColor),), ) :Container()

            ],
          ),
        ),
      ),
    );
  }
}
