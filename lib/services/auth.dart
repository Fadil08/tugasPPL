import 'package:belajar_firebase/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../homePage.dart';
import '../signup.dart';

Future logindata(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-notfound') {
      print('object');
    } else if (e.code == 'wrong-password') {
      print('wrong password');
    } else if (e.code == 'weak-password') {
      print('The Pasword profided is too week');
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future registerakun(email, password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(), password: password.text.trim());
    // await DatabasesService(uid: email.uid).updateData('mahasisawa', 'fadhil', 10);
    return true;
  }on FirebaseAuthException catch(e){
    
  } 
  catch (e) {
    print(e.toString());
    return false;
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return SignUpPage();
          }
        },
      ),
    );
  }
}
