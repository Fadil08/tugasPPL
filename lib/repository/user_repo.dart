import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabasesService {
  final String uid;
  DatabasesService({required this.uid});
  final CollectionReference gondurCollection =
      FirebaseFirestore.instance.collection('gondur');

  Future updateData(String sugar, String name, int streagth) async {
    return await gondurCollection.doc(uid).set({
      'sugars': sugar,
      'name': name,
      'streagth':streagth
    });
  }
}
