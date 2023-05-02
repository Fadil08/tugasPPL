import 'package:belajar_firebase/widgets/pages/profile/widgetappbarr.dart';
import 'package:flutter/material.dart';

class MyeditProfileuser extends StatefulWidget {
  const MyeditProfileuser({super.key});

  @override
  State<MyeditProfileuser> createState() => _MyeditProfileuserState();
}

class _MyeditProfileuserState extends State<MyeditProfileuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuiltAppabar(context),
    );
  }
}