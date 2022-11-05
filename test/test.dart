// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  try {
    await addData();
  } catch (e) {
    // error handling
  }
}

getAll() async{
  var db = FirebaseFirestore.instance;
  final docRef = db.collection("cities").doc("SF");
  // docRef.get().then(
  //   (DocumentSnapshot doc) {
  //     final data = doc.data() as Map<String, dynamic>;
  //     // ...
  //   },
  //   onError: (e) => print("Error getting document: $e"),
  // );
  try {
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    // ...
  } catch (e) {
    print("Error getting document: $e"),
  }
}

Future<void> addData() async {
  // Add a new document with a generated id.
  final data = {"name": "Tokyo", "country": "Japan"};

  var db = FirebaseFirestore.instance;

  //db.collection("cities").add(data).then((documentSnapshot) =>
  //  print("Added Data with ID: ${documentSnapshot.id}"));
  //try {
  var documentSnapshot = await db.collection("cities").add(data);
  print("Added Data with ID: ${documentSnapshot.id}");
  // } catch (e) {
  // print(e);
  // }
}
