import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class databaseUser {
  static Stream<QuerySnapshot> getdataUser() {
    return firestore
        .collection("users")
        .where("idUser", isEqualTo: auth.currentUser?.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot> getdataProfile() {
    return firestore
        .collection("users")
        .where("uid", isEqualTo: auth.currentUser?.uid)
        .snapshots();
  }
}
