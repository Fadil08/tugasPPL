import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_alert_dialog/models/alert_dialog_text.dart';
import 'package:smart_alert_dialog/smart_alert_dialog.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import '../Page_Home.dart';
import 'Page_signUp.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import 'Page_forgatePassword.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ignore: non_constant_identifier_names
  Future SignIn() async {
    try {
      print('ok');
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } catch (e) {
      return erorsnackbar(e.toString());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void erorsnackbar(eror) {
    AnimatedSnackBar.material(
      '$eror',
      type: AnimatedSnackBarType.info,
    ).show(context);
  }

  // void SignInUsers() async {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // padding:EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            width: MediaQuery.of(context).size.width * 1,

            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                border: Border.fromBorderSide(BorderSide(
                    style: BorderStyle.solid,
                    color: Color.fromARGB(255, 150, 218, 185),
                    width: 0.5)),
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromARGB(255, 3, 216, 10),
                      Color.fromARGB(32, 109, 201, 136)
                    ]),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Goundur',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  'Sistem Informasi',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal),
                ),
                Text('Management Tanaman Pertanian')
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.1,
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Text(
              'Selamat Datang',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.1,
          // ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              validator: ((value) {
                if (value!.isEmpty) {
                  return ("Data tidak boleh kosong");
                }
                return null;
              }),
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              scrollPadding: EdgeInsets.all(10),
              decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  labelText: 'Email',
                  fillColor: Colors.black54,
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.email)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
                validator: ((value) {
                  if (value!.isEmpty) {
                    return ("Data tidak boleh kosong");
                  }
                  return null;
                }),
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                obscureText: true,
                scrollPadding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 02),
                decoration: InputDecoration(
                    hintText: 'Passsword',
                    labelText: 'Password',
                    fillColor: Colors.black54,
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility_off))),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text(
                      'Forget Password ?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 31, 9, 231), fontSize: 15),
                    ),
                  )
                ],
              )),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  if (emailController.text.trim().isEmpty ||
                      passwordController.text.trim().isEmpty) {
                    return eroroAlertIsEmpty(context);
                  } else {
                    snackbarSucses();
                    SignIn();
                  }
                },
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                )),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'sudah memiliki akun..?',
                  textAlign: TextAlign.center,
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PageSignUp();
                    }));
                  },
                  child: Text(
                    'register',
                    textAlign: TextAlign.center,
                  ),
                ),

                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.2,
                // )
              ],
            ),
          )
        ],
      ),
    );
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

  void eroroAlertIsEmpty(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => SmartAlertDialog(
          isDismissible: true,
          title: 'Message Login',
          text: AlertDialogText(),
          message: 'Username and password cannot be empty'),
    );
  }
}
