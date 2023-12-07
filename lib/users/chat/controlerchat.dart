import 'package:belajar_firebase/users/chat/modelchat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

List<ModelData> userdata = [];
final auth = FirebaseAuth.instance.currentUser;

class chatControler {
  static void GoChat({required ModelData item}) {}
  final db = FirebaseFirestore.instance;
  static Stream<QuerySnapshot> getData(collection, where) {
    return FirebaseFirestore.instance
        .collection(collection)
        .where("status", isEqualTo: "${where}")
        .snapshots();
  }

  static Stream<QuerySnapshot> userlogin() {
    print(auth!.uid);
    return FirebaseFirestore.instance
        .collection('users')
        // .where("status", isEqualTo: "user")
        .where('uid', isEqualTo: auth!.uid.toString())
        .snapshots();
  }
}
