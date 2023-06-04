import 'package:belajar_firebase/auth/Page_SIgnIn.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme.dart';
import '../admin/authAdmin/loginAdmin.dart';

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({super.key});

  @override
  State<MyLandingPage> createState() => _MyLandingPageState();
}

String? accseptlogin;
List pilihLogin = ["admin", "seller", "user"];

class _MyLandingPageState extends State<MyLandingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 90, left: 10),
            child: Text(
              "GONDUR",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: ColorPelatte.hintColor),
            ),
            height: size.height * 0.2,
            width: size.width * 1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.topCenter,
                    colors: [
                  Colors.green,
                  Color.fromARGB(255, 235, 240, 235),
                ])),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: size.height * 0.1,
            width: size.width * 1,
            decoration: BoxDecoration(color: Colors.green),
            child: Text(
              "Welcome Page With In GondurApps",
              // textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: ColorPelatte.hintColor),
            ),
          ),
          Container(
            width: size.width * 1,
            height: size.height * 0.425,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/imgview/pngwing.com.png"))),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(5),
              width: size.width * 0.5,
              height: size.height * 0.07,
              // ignore: sort_child_properties_last
              child: TextButton(
                onPressed: () {
                  dataPref.savestatus();
                  
                  if (accseptlogin == "admin") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => pageLoginAdmin()));
                  } else if (accseptlogin == 'user' ||
                      accseptlogin == 'suplier') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => pageLogin()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyLandingPage()));
                  }
                },
                child: Text(
                  "Get Stated",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: ColorPelatte.hintColor),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.green.shade500,
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(top: 4, left: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green,
            ),
            width: size.width * 0.3,
            height: size.height * 0.05,
            child: DropdownButton(
              dropdownColor: Colors.green,
              iconEnabledColor: Colors.white,
              value: accseptlogin,
              items: pilihLogin.map((value) {
                return DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  accseptlogin = value as String?;
                });
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class dataPref {
  static void savestatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("status", accseptlogin!);
  }

  static Future<void> dellet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("status");
  }
}

