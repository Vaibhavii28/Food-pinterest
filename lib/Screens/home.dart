import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/Screens/allRecipes.dart';
import 'package:food_recipes/Screens/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipes/Screens/details.dart';
import 'package:food_recipes/Screens/savedlist.dart';
import 'package:food_recipes/Services/Recipes.dart';
import 'package:food_recipes/Services/firebase.dart';

class MyHome extends StatefulWidget {
  MyHome();

  static const String id = 'home_screen';

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool gotdata = false;
  bool tag = false;
  List savedlist=[];
  // List freshlist = [
  //   {"image": "assets/food/food1.png", "name": "Asian Glazed chicken Thighs"},
  //   {"image": "assets/food/food2.png", "name": "Blueberry Muffins"},
  //   {"image": "assets/food/food1.png", "name": "Asian Glazed chicken Thighs"},
  //   {"image": "assets/food/food2.png", "name": "Blueberry Muffins"},
  // ];
  List<RecipeObject> listofobj = [];
  // List recommendedList = [
  //   {"image": "assets/food/food3.png", "name": "French Toast with Berries"},
  //   {"image": "assets/food/food4.png", "name": "Glazed Salmon"},
  //   {"image": "assets/food/food5.png", "name": "Cherry Clafoutis"},
  //   {"image": "assets/food/food3.png", "name": "French Toast with Berries"},
  //   {"image": "assets/food/food4.png", "name": "Glazed Salmon"},
  //   {"image": "assets/food/food5.png", "name": "Cherry Clafoutis"},
  // ];


  void getData() async {

    listofobj = await NetworkHelper().getRandomRecipe();
    for(var obj in listofobj)
      {

        obj.calories= await NetworkHelper().getNutriData(obj.id);
      }
    setState(() {
      gotdata = true;
      print("ded");
    });

  }

  var firestore=FirebaseFirestore.instance;
  // Future<void> getRecipeData() async{
  //   FirebaseAuth auth= FirebaseAuth.instance;
  //   var userData = await firestore.collection(firebaseService.kList2).doc(auth.currentUser?.uid).get();
  //   var list= userData.get(firebaseService.kList2);
  //   // final allIdData= querySnapshot.docs.map((doc) => doc.get(firebaseService.kId[0])).toList();
  //   for(var item in list )
  //     {
  //       print(item["name"]);
  //     }
  //
  // }



  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kLightColor,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        getData();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/menu-burger.svg',
                        height: 32.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                         Navigator.pushNamed(context, MySaved.id);

                      },

                      child: Icon(Icons.favorite_rounded, color: Colors.red,size: 32.0,)
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),

                SizedBox(
                  height: 12.0,
                ),
                Text("What would you like to cook today?",
                    style: TextStyle(
                        fontSize: 28.0,
                        color: kDarkcolor,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 16.0,
                ),
                Row(

                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          boxShadow: [kBoxShadow],
                            color: kLightColor,
                            borderRadius: BorderRadius.circular(14.0)),
                        child: TextField(
                          cursorColor: kDarkcolor,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: kDarkcolor,
                                size: 34.0,
                              ),
                              hintText: "Search for a recipe",
                              hintStyle: TextStyle(
                                  color: kDarkcolor, fontSize: 20.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    // GestureDetector(
                    //   onTap: () => print("Filter"),
                    //   child: Container(
                    //       padding: EdgeInsets.symmetric(
                    //           vertical: 18.0, horizontal: 18.0),
                    //       decoration: BoxDecoration(
                    //           color: kBackgroundColor,
                    //           borderRadius: BorderRadius.circular(14.0)),
                    //       child: SvgPicture.asset(
                    //         'assets/icons/settings.svg',
                    //         //color: kDarkcolor,
                    //         height: 22.0,
                    //       )),
                    // )
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today's Fresh Recipes",
                        style: TextStyle(fontSize: 22.0, color: kDarkcolor)),
                    // GestureDetector(
                    //   onTap: () => print("See All fresh recipes"),
                    //   child: Text("See All",
                    //       style:
                    //           TextStyle(fontSize: 18.0, color: kPrimaryColor)),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  height: 240.0,
                  child: gotdata? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyDetails(
                                index, listofobj[index], tag = false
                               ),
                          ),
                        ),
                        child: Container(
                          height: 240.0,
                          width: 200.0,
                          margin: EdgeInsets.only(right: 32.0),
                          decoration: BoxDecoration(

                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // Hero(
                                  //   tag: "fresh$index",
                                  //   child: gotdata ? ClipRRect(borderRadius: BorderRadius.all(Radius.circular(16.0), ), child: Image.network(listofobj[index].image, height: 100.0, )) : ClipRRect(
                                  //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  //     child: Image.asset(
                                  //       'assets/food/food1.png',
                                  //       height: 100.0,
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          topLeft: Radius.circular(15)),
                                      color: kBackgroundColor,
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        child: gotdata
                                            ? Image.network(
                                                listofobj[index].image,
                                                height: 100.0,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/food/food1.png')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            listofobj[index].selected = !listofobj[index].selected;
                                            if(listofobj[index].selected){
                                              //savedlist.add(listofobj[index]);
                                              firebaseService().addRecipe2(listofobj[index]);
    //firebaseService().checkRecipe(listofobj[index]);

    }
                                            else {
                                              //savedlist.remove(listofobj[index]);
                                              firebaseService().removeRecipe(listofobj[index]);
                                            }
                                          });
                                        },
                                        child: Icon(
                                          listofobj[index].selected? Icons.favorite : Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Breakfast",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: kBluecolor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Container(
                                      width: 185.0,
                                      child: gotdata
                                          ? Text(
                                              listofobj[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: kDarkcolor,
                                                fontWeight: FontWeight.bold
                                              ),
                                            )
                                          : Text(
                                              "Asian glazed chicken thighs",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    // Row(
                                    //     children: List.generate(
                                    //   5,
                                    //   (index) => Icon(
                                    //     Icons.star,
                                    //     color: kOrangeColor,
                                    //     size: 16.0,
                                    //   ),
                                    // )),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    Text(
                                       "${gotdata? listofobj[index].calories: 120} calories" ,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: kDarkcolor,
                                              size: 16.0,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              "${gotdata ? listofobj[index].time : 10} mins",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: kDarkcolor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 32.0,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/bell.svg',
                                              height: 16.0,
                                              color: kDarkcolor,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              "${gotdata ? listofobj[index].servings : 1} servings",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: kDarkcolor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ) :Container(child: Center(child: CircularProgressIndicator())),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recommended", style: TextStyle(fontSize: 22.0, color: kDarkcolor,)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, MyAllRecipes.id);
                      },
                      child: Text("See All",
                          style:
                              TextStyle(fontSize: 18.0, color: kPrimaryColor)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                gotdata? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyDetails(
                              index,listofobj[index], tag = false,
                              ))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 130.0,
                          width: MediaQuery.of(context).size.width,

                          margin: EdgeInsets.only(bottom: 16.0),
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [

                              Container(
                                  height: 180.0,
                                  width: 120.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        topLeft: Radius.circular(15)),
                                    color: kBackgroundColor,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)),
                                    child: gotdata
                                        ? Image.network(
                                            listofobj[index + 4].image,
                                            height: 180.0,
                                            width: 120.0,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/food/food1.png",
                                            height: 180.0,
                                            width: 120.0,
                                            fit: BoxFit.cover,
                                          ),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width/1.8,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Breakfast",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: kBluecolor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          Container(
                                            padding: EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  listofobj[index+4].selected = !listofobj[index+4].selected;
                                                  if(listofobj[index+4].selected){
                                                    savedlist.add(listofobj[index+4]);
                                                    firebaseService().addRecipe2(listofobj[index+4]);
                                                  }
                                                  else {
                                                    savedlist.remove(listofobj[index+4]);
                                                    //firebaseService().removeRecipe(listofobj[index]);
                                                  }
                                                });
                                              },
                                              child: Icon(
                                                listofobj[index+4].selected? Icons.favorite : Icons.favorite_border,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      gotdata
                                          ? Container(
                                        width: MediaQuery.of(context).size.width/2.5,
                                            child: Text(
                                                listofobj[index + 4].name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: kDarkcolor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                          )
                                          : Text(
                                              "Asian glazed chicken thighs",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                      // Text(
                                      //   recommendedList[index]["name"],
                                      //   overflow: TextOverflow.ellipsis,
                                      //   style: TextStyle(
                                      //     fontSize: 18.0,
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Row(
                                          //   children: List.generate(
                                          //     5,
                                          //     (index) => Icon(
                                          //       Icons.star,
                                          //       color: kOrangeColor,
                                          //       size: 16.0,
                                          //     ),
                                          //   ),
                                          // ),
                                          //
                                          Text(
                                            //SizedBox(
                                            //   width: 6.0,
                                            // ),
                                            "${gotdata? listofobj[index+4].calories: 120} calories" ,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                color: kDarkcolor,
                                                size: 16.0,
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              Text(
                                                "${gotdata ? listofobj[index + 4].time : 10} mins",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: kDarkcolor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   width: 32.0,
                                          // ),
                                          Row(

                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/bell.svg',
                                                height: 16.0,
                                                color: kDarkcolor,
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              Text(
                                                "${gotdata ? listofobj[index].servings : 1} servings",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: kDarkcolor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ) :Container(child: Center(child: CircularProgressIndicator()))
              ],
            ),
          ),
        ));
  }
}

class RecipeObject {
  String name;
  String image;
  String time;
  String servings;
  String id;
  String instructions;
  String priceperserving;
  bool selected=false;
  String calories="120";

  RecipeObject(
      {required this.name,
      required this.image,
      required this.time,
      required this.servings,
      required this.id,
      required this.instructions,
      required this.priceperserving,
      });

  @override
  String toString() {
    // TODO: implement toString
    return 'RecipeObject{name : $name, image: $image , time: $time , servings: $servings}';
  }
}

class NutritionObject {
  String calories;

  NutritionObject({required this.calories});

  @override
  String toString() {
    return 'NutritionObject{calories: $calories}';
  }
}


