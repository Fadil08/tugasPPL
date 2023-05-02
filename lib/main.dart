import 'package:belajar_firebase/models/addproduct/add_penjadwalan.dart';
import 'package:belajar_firebase/service/auth.dart';

import 'package:belajar_firebase/signup.dart';
import 'package:belajar_firebase/widgets/pages/penjadwalan/editpenjadwalan.dart';

import 'package:belajar_firebase/widgets/pages/penjadwalan/homePenjadwalan.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'coba.dart';
import 'homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePenjadwalan(),
    );
  }
}
