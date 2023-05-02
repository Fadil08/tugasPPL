import 'package:belajar_firebase/widgets/pages/profile/widgetappbarr.dart';
import 'package:flutter/material.dart';


import '../../../theme.dart';
// import 'package:gondur/theme.dart';
// import 'package:gondur/widget/pages/profile/widgetappbarr.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({super.key});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BuiltAppabar(context),
      // appBar: AppBar(
      //   title: Text(
      //     "My Profile",
      //     style: TextStyle(fontSize: 20, color: ColorPelatte.secondary),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.white60,
      // ),
      body: Stack(children: [
        Positioned(
            top: size.height * 0.1,
            left: size.width * 0.3,
            width: size.width * 0.4,
            height: size.height * 0.2,
            child: CircleAvatar()),
        Positioned(
            top: size.height * 0.3,
            left: size.width * 0.3,
            width: size.width * 0.4,
            height: size.height * 0.070,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorPelatte.colorwhite,
                  borderRadius: BorderRadius.circular(50)),
            )),
      ]),
    );
  }
}
