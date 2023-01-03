import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipes/Screens/constants.dart';
import 'package:food_recipes/Services/firebase.dart';
import '../Services/Recipes.dart';
import 'details.dart';
import 'home.dart';

class MySaved extends StatefulWidget {
  final int index;
  RecipeObject recobj;

  final bool tags;
  MySaved(this.index,this.recobj, this.tags);

  static const String id = 'saved_screen';

  @override
  State<MySaved> createState() => _MySavedState();
}

class _MySavedState extends State<MySaved> {
  List <String> calories= [];
  List<RecipeObject> listofobj = [];
  bool gotdata = false;
  void getData() async {
    listofobj = await NetworkHelper().getRandomRecipe();
    for(var obj in listofobj)
    {
      calories.add(await NetworkHelper().getNutriData(obj.id));
    }
    setState(() {
      gotdata = true;
    });
  }
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
      body: Container(
        margin: EdgeInsets.only(top: 64.0, left: 14.0, right: 14.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "My Saved Recipes",
                  style: TextStyle(fontSize: 36.0, color: kDarkcolor),
                ),
              ),
            ),
            // ListView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: 6,
            //   padding: EdgeInsets.zero,
            //   itemBuilder: (context, index) {
            //     return RecipeCard();
            //   },
            // ),
            MessagesStream()
          ],
        ),
      ),
    );
  }
}

class RecipeCard extends StatefulWidget {
  RecipeObject recobjj;

  RecipeCard(
      {required this.recobjj});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyDetails(
            0, widget.recobjj, false,
        ),
      ),
    ),
      child: Container(
        height: 120.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            // Hero(
            //   tag: "recommen$index",
            //   child: gotdata
            //       ? Image.network(
            //           listofobj[index + 4].image,
            //           height: 180.0,
            //           width: 120.0,
            //           fit: BoxFit.contain,
            //         )
            //       : Image.asset(
            //           recommendedList[index]["image"],
            //           height: 180.0,
            //           width: 120.0,
            //           fit: BoxFit.contain,
            //         ),
            // ),
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
                  child: Image.network(widget.recobjj.image,
                    height: 180.0,
                    width: 120.0,
                    fit: BoxFit.cover,
                  ),
                )),
            Container(
              width: 200.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 6.0,
                    ),
                    Text(
                      widget.recobjj.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: kDarkcolor,
                        fontWeight: FontWeight.bold
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          "${widget.recobjj.calories} calories",
                          style: TextStyle(
                            fontSize: 16.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                             "${widget.recobjj.time} mins",
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
                              "${widget.recobjj.servings} servings" ,
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
            //
            Expanded(

              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      widget.recobjj.selected = !widget.recobjj.selected;
                      if(!widget.recobjj.selected){
                        firebaseService().removeRecipe(widget.recobjj);
                        widget.recobjj.selected=!widget.recobjj.selected;
                      }

                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      widget.recobjj.selected? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  FirebaseFirestore firestore1 = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(

      stream: firestore1.collection(firebaseService.kList2).where('userid', isEqualTo: auth.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs;
        List<RecipeCard> messageBubbles = [];

        for (var message in messages) {


            // final allIdData= querySnapshot.docs.map((doc) => doc.get(firebaseService.kId[0])).toList();

              RecipeObject recipeobject1=RecipeObject(name: message["name"], image: message["image"], time: message["time"]
                  , servings: message["servings"], id: message["id"], instructions: message["instructions"],
                  priceperserving: message["priceperserving"], );
              recipeobject1.calories= message["calories"];
              recipeobject1.selected= message["selected"];
              messageBubbles.add(RecipeCard(
                recobjj: recipeobject1,
              ));

           // print(messageBubbles[0].name);

        }
        return Container(
          height: MediaQuery.of(context).size.height/1.3,
          child: ListView.builder(
            shrinkWrap: true,
            reverse: false,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            itemCount: messageBubbles.length,
            itemBuilder: (BuildContext context, int index)
            {
              return messageBubbles[index];
            },
          )
          // ListView(
          //   shrinkWrap: true,
          //   reverse: false,
          //   padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          //   children: messageBubbles,
          // ),
        );
      },
    );
  }
}
