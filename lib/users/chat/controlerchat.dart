import 'package:belajar_firebase/users/chat/modelchat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

List<ModelData> userdata = [];

class chatControler {
  static void GoChat({required ModelData item}) {}
  final db = FirebaseFirestore.instance;

  // final token = User
}
