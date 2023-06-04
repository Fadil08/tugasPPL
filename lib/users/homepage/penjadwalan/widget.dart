import 'package:flutter/material.dart';
import 'theme.dart';

class myhome extends StatefulWidget {
  const myhome({super.key});

  @override
  State<myhome> createState() => _myhomeState();
}

class _myhomeState extends State<myhome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(children: [
        Container(
          width: size.width * 1,
          height: size.height * 0.15,
          child: Row(
            children: [
              Container(
                width: size.width * 0.2,
                height: size.height * 0.5,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/test-auth-f22d6.appspot.com/o/3e4ae5c0-1494-46f7-ade0-30f999997148.jpg?alt=media&token=0e72d0e0-16b4-46b8-94ae-e5407dedec1a"),
                ),
              ),
              Text(
                "Welcome to My Apps",
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: ColorPelatte.primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
              width: size.width * 0.2,
              height: size.height * 0.2,
              decoration: BoxDecoration(color: ColorPelatte.primaryColor),
              child: ListView(
                children: [
                  Positioned(
                    left: 20,
                    bottom: 20,
                    width: 30,
                    height: 50,
                    child: Container(
                      width: 30,
                      height: 50,
                      decoration: BoxDecoration(color: ColorPelatte.hintColor),
                    ),
                  )
                ],
              )),
        )
      ]),
    );
  }
}
