import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes/Screens/home.dart';

class firebaseService {

  static const kId = 'id';
  static const kList2= 'savedrecipes';
  var auth = FirebaseAuth.instance;
  var firestore1 = FirebaseFirestore.instance;
  bool isInWishlist = false;
  late CollectionReference collectionReference;


  void addRecipe2(RecipeObject recobject) async{
    await firestore1.collection(kList2).doc().set(
        {
          "id": recobject.id,
          "image": recobject.image,
          "instructions": recobject.instructions,
          "name": recobject.name,
          "priceperserving": recobject.priceperserving,
          "selected": recobject.selected,
          "servings": recobject.servings,
          "time": recobject.time,
          "calories": recobject.calories,
          "selected": recobject.selected,
          "userid": auth.currentUser!.uid,
        });
  }

  void removeRecipe(RecipeObject recobject) async {
    try {
    Query query = firestore1.collection(kList2).where('userid', isEqualTo: auth.currentUser!.uid).where('id', isEqualTo: recobject.id);

// Get the document reference by executing the query
      DocumentReference docRef = await query.get().then((snapshot) {
        return snapshot.docs[0].reference;
      });

// Delete the document
      await docRef.delete();
      }
    catch(e){print(e);}
  }
  void checkRecipe(RecipeObject recobject) async{
    DocumentReference docRef = firestore1.collection(kList2).doc();
    bool exists = await docRef.get().then((snapshot) => snapshot.exists);
    print(exists);
  }
}
