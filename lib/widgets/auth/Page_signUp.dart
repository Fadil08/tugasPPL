import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../service/auth.dart';
import '../../services/auth.dart';
import '../../theme.dart';


class PageSignUp extends StatefulWidget {
  const PageSignUp({super.key});
  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  final _emailcontroler = TextEditingController();
  final fullname = TextEditingController();
  final _passwordcontroler = TextEditingController();
  final _ConfimPasswordControler = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> SignUp() async {
    try {
      print('ok');
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailcontroler.text.trim(),
              password: _passwordcontroler.text.trim());

      // Map<String, dynamic> Userdata = {
      //   "email": _emailcontroler.text,
      //   "Fullname": fullname.text.trim(),
      //   "password": _passwordcontroler.text
      // };
      // if (userCredential != null) {
      //   DatabaseMethods().AddUserInfoToDB(_auth.currentUser!.uid, Userdata);
      // }
      adduserDetails(fullname.text.trim(), _emailcontroler.text.trim());
      snackbarSucses();
    } catch (e) {
      return erorsnackbar(e.toString());
    }
  }

  Future adduserDetails(
    String firstname,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection("users").add({
      'fullname': firstname,
      'email': email,
    });
  }

  @override
  void erorsnackbar(eror) {
    AnimatedSnackBar.material(
      '$eror',
      type: AnimatedSnackBarType.info,
    ).show(context);
  }

  void snackbarSucses() {
    AnimatedSnackBar.rectangle(
      'Success',
      'This is a success Login in Apps',
      type: AnimatedSnackBarType.success,
      brightness: Brightness.dark,
    ).show(
      context,
    );
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            width: size.width * 1,
            height: size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'GONDUR',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Sistem Informasi',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                Text(
                  'Management Tanaman Pertanian',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                )
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: ColorPelatte.primaryColor)),
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 10),
          child: Text(
            'Register',
            style: TextStyle(
                color: ColorPelatte.fontcolor1,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _emailcontroler,
            decoration: InputDecoration(
              hintText: 'Masukkan Email',
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: fullname,
            // maxLines: 6,
            decoration: InputDecoration(
              hintText: 'fullname',
              labelText: 'Fullname',
              border: OutlineInputBorder(),
              fillColor: ColorPelatte.primaryColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(10),
          child: TextFormField(
              keyboardType: TextInputType.name,
              maxLength: 8,
              obscureText: true,
              controller: _passwordcontroler,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'password',
                border: OutlineInputBorder(),
              )),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          width: size.width * 0.5,
          color: ColorPelatte.secondary,
          child: ElevatedButton(
            onPressed: () {
              if (_emailcontroler.text.isEmpty ||
                  _passwordcontroler.text.isEmpty ||
                  fullname.text.isEmpty) {
                return erorsnackbar(context);
              } else {
                SignUp();
                fullname.clear();
                _emailcontroler.clear();
                _passwordcontroler.clear();
              }
            },
            child: Text('Register'),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sudah Memiliki Akun?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: ColorPelatte.fontcolor1),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AuthPage();
                    }));
                  },
                  child: Text(
                    'Masuk',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorPelatte.secondary),
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}
