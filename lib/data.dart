import 'package:cloud_firestore/cloud_firestore.dart';
import "auth.dart";

final db = FirebaseFirestore.instance;

late String dateTime;
final CollectionReference usersCollectionRef = db.collection('Users');
late DocumentReference curUserDocRef;
late CollectionReference curUserPurHisColRef;

void initUserData() {
  curUserDocRef = db.doc('Users/${auth.currentUser!.uid}');
  curUserPurHisColRef = curUserDocRef.collection('Purchase History');
}

Future<bool> deleteAccount() async {
  bool isSuccess = true;
  await curUserPurHisColRef.get().then((QuerySnapshot historyCollection) async {
    {
      for (DocumentSnapshot entry in historyCollection.docs) {
        await entry.reference
            .collection('FoodItems')
            .get()
            .then((QuerySnapshot foodItemsCollection) async {
          for (DocumentSnapshot foodItem in foodItemsCollection.docs) {
            await foodItem.reference.delete();
          }
        }).catchError((e) {
          isSuccess = false;
        });

        await entry.reference.delete();
      }
    }
  });
  await curUserDocRef
      .collection("Custom Foods")
      .get()
      .then((QuerySnapshot querySnapshot) async {
    for (DocumentSnapshot foodItem in querySnapshot.docs) {
      await foodItem.reference.delete();
    }
  }).catchError((e) {
    isSuccess = false;
  });

  await curUserDocRef.delete();
  await auth.currentUser?.delete();
  await auth.signOut();
  return isSuccess;
}
