import 'package:belajar_firebase/homePage.dart';
import 'package:belajar_firebase/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future SignUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }

  // Future SignIn() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passwordController.text.trim());
  //     Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     Navigator.pop(context);
  //     if (e.code == 'user-notfound') {
  //       messageEmail();
  //     } else if (e.code == 'wrong-password') {
  //       MessagePassword();
  //     }
  //   }
  // }

  void messageEmail() {
    showDialog(
        context: context,
        builder: ((context) {
          return const AlertDialog(
            backgroundColor: Colors.purpleAccent,
            title: Center(
              child: Text(
                'Incorect Emial',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
          );
        }));
  }

  void MessagePassword() {
    showDialog(
        context: context,
        builder: ((context) {
          return const AlertDialog(
            backgroundColor: Colors.purpleAccent,
            title: Center(
              child: Text(
                'Incorect Password',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
          );
        }));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API TEST'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 200,
            // color: Colors.amber,
            // alignment: Alignment.center,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
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
            child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                scrollPadding: EdgeInsets.all(10),
                decoration: InputDecoration(
                    hintText: 'Passsword',
                    labelText: 'Password',
                    fillColor: Colors.black54,
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.password),
                    suffixIcon: Icon(Icons.add))),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forget Password ?',
                      style: TextStyle(
                          color: Colors.purpleAccent[600], fontSize: 15),
                    ),
                  )
                ],
              )),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () async {
                  bool shouldNavigate =
                      await logindata(emailController.text, passwordController.text);
                  if (shouldNavigate) {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
                  }
                },
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}
