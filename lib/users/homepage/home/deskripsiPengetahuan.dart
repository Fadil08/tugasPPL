import 'package:flutter/material.dart';
import 'package:mychat/util.dart';

class Mydeskripsi extends StatefulWidget {
  const Mydeskripsi({super.key});

  @override
  State<Mydeskripsi> createState() => _MydeskripsiState();
}

class _MydeskripsiState extends State<Mydeskripsi> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        Container(
          width: size.width * 1,
          height: size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bayam.png"), fit: BoxFit.cover),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          width: size.width * 1,
          child: Text(
            "Title",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          width: size.width * 1,
          child: Text(
            "Deskripsi",
            style: TextStyle(fontSize: 15),
          ),
        ),
      ]),
    );
  }
}
