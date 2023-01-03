import 'package:flutter/material.dart';
import 'package:food_recipes/Screens/constants.dart';
import 'package:food_recipes/Screens/home.dart';
import 'package:html/parser.dart';

import '../Services/firebase.dart';

class MyDetails extends StatefulWidget {
  final int index;
  RecipeObject recobj;

  final bool tags;

  MyDetails(this.index,this.recobj, this.tags );

  static const String id = 'details_screen';


  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
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
          margin: EdgeInsets.only(top: 64.0, left: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 28.0,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: widget.recobj.selected? [kBoxShadow] : [],
                        color: widget.recobj.selected? kLightColor: kPrimaryColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: IconButton(
                      onPressed: () {
                       setState(() {
                         widget.recobj.selected=!widget.recobj.selected;
                         if(widget.recobj.selected){

                           firebaseService().addRecipe2(widget.recobj);
                         }
                         else {
                           firebaseService().removeRecipe(widget.recobj);
                         }
                       });
                      },
                      icon: Icon(
                        Icons.star,
                        color: widget.recobj.selected? Colors.red: kLightColor,
                      ),
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(
                  widget.recobj.name,
                  style: TextStyle(fontSize: 36.0, color: kDarkcolor, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "\$",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kPrimaryColor,
                      ),
                    ),
                    TextSpan(
                      text: widget.recobj.priceperserving,
                      style: TextStyle(
                        fontSize: 36.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Calories",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: kDarkcolor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "${widget.recobj.calories} calories",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold, color: kPrimaryColor),
                          ),
                          SizedBox(
                            height: 36.0,
                          ),
                          Text(
                            "Time",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: kDarkcolor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "${widget.recobj.time} mins",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold, color: kPrimaryColor),
                          ),
                          SizedBox(
                            height: 36.0,
                          ),
                          Text(
                            "Total Serve",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: kDarkcolor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "${widget.recobj.servings} servings",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold, color: kPrimaryColor),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                        ],
                      ),
                    ),
                    Hero(
                      tag: widget.tags
                          ? "fresh${widget.index}"
                          : "recommend${widget.index}",
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                        child: Image.network(
                          widget.recobj.image,
                          height: 250.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text(
                "Description",
                style: TextStyle(fontSize: 24.0, color: kDarkcolor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 28.0, bottom: 28.0),
                child: Text(
                  parse(widget.recobj.instructions).body!.text,
                  style: TextStyle(fontSize: 16.0, color: kDarkcolor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
