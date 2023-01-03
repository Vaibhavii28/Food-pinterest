import 'dart:convert';

import 'package:food_recipes/Screens/constants.dart';
import 'package:food_recipes/Screens/home.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {

  final String url='https://api.spoonacular.com/recipes/';


  Future getRandomRecipe() async {
    http.Response response = await http.get(Uri.parse('${url}random?apiKey=$apiKey2&number=10'));

    if (response.statusCode == 200) {
      String data = response.body;
      var recipedata= jsonDecode(data);
      List <RecipeObject> list1= [];
      for (var obj in recipedata['recipes'])
        {
          list1.add(RecipeObject(name: obj['title'],  time: obj['readyInMinutes'].toString(),image: obj['image'], servings: obj['servings'].toString(), id: obj['id'].toString(), instructions: obj['instructions'], priceperserving: obj['pricePerServing'].toString(), ));
        }
      print (list1);
      return list1;
    } else {
      print(response.statusCode);
    }

  }

  Future getNutriData(var id) async {
    http.Response response = await http.get(Uri.parse('${url}${id}/nutritionWidget.json?apiKey=$apiKey2'));

    if (response.statusCode == 200) {
      String data = response.body;
      var recipedata= jsonDecode(data);
      print(recipedata['calories']);
      return recipedata['calories'];
    } else {
      print(response.statusCode);
    }
  }

  Future getRandomRecipe2() async {
    http.Response response = await http.get(Uri.parse('${url}random?apiKey=$apiKey2&number=30'));

    if (response.statusCode == 200) {
      String data = response.body;
      var recipedata= jsonDecode(data);
      List <RecipeObject> list1= [];
      for (var obj in recipedata['recipes'])
      {
        list1.add(RecipeObject(name: obj['title'],  time: obj['readyInMinutes'].toString(),image: obj['image'], servings: obj['servings'].toString(), id: obj['id'].toString(), instructions: obj['instructions'], priceperserving: obj['pricePerServing'].toString(), ));
      }
      print (list1);
      return list1;
    } else {
      print(response.statusCode);
    }

  }
}


