import 'dart:io';
import 'package:belajar_firebase/auth/auth.dart';
import 'package:belajar_firebase/Page_Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ChatUsers {
  String? name;
  String? messageText;
  String? imageURL;
  String? time;
  String? from_name;
  String? to_name;
  ChatUsers({
    this.name,
    this.messageText,
    this.imageURL,
    this.time,
    this.from_name,
    this.to_name,
  });
  Map<String, dynamic> toJson() {
    return {
      "from_name": from_name,
      "to_name": to_name,
      "time": time,
      "messageText": messageText,
      "imageURL": imageURL,
    };
  }

  factory ChatUsers.fromJson(Map<String, dynamic> json) {
    return ChatUsers(
      from_name: json["from_name"],
      to_name: json["to_name"],
      time: json["time"],
      imageURL: json["imageURL"],
    );
  }
}

class dattasChat {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Future signup(
      String email, String password, String confirmPass, context) async {
    var user;
    if (password == confirmPass) {
      try {
        user = await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then(
          (value) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return CompleteProfile(user: value.user);
            //     },
            //   ),
            // );
          },
        );
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message.toString());
      }
    } else {
      Fluttertoast.showToast(msg: 'Password Is Not Matched');
    }
    return user;
  }

  complete({required User user, name, number, image, context}) async {
    String time = DateTime.timestamp().toString();
    try {
      await firestore.collection('users').doc(time).set({
        'email': user.email,
        'name': name,
        'number': number,
        'image': image,
      }).then(
        (value) {
          Fluttertoast.showToast(msg: 'Profile Completed');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AuthPage();
              },
            ),
          );
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  login(email, pass, context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass).then(
        (value) {
          Fluttertoast.showToast(msg: 'Logged In');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PageMain();
              },
            ),
          );
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future getInfo() async {
    var email = auth.currentUser!.email;
    var datas;
    try {
      final response = await firestore.collection('user').get();
      final data =
          response.docs.where((element) => element['email'] == email).first;
      datas = data;
    } catch (e) {}
    return datas;
  }

  static Future selectImage(context) async {
    final storage = FirebaseStorage.instance;
    var url;

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('File Uploading.......'),
            content: Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            ),
          );
        });
    try {
      final uploaded = await storage.ref(image!.name).putFile(File(image.path));
      var u = await uploaded.ref.getDownloadURL();
      url = u;
    } catch (e) {}

    Navigator.pop(context);

    return url;
  }
}

class ModelData {
  String? namaLengkap;
  String? email;
  String? password;
  String? pekerjaan;
  String? usia;
  String? uid;
  String? noTelp;
  String? status;
  String? gender;
  String? domisili;
  String? image;

  ModelData(
      {this.namaLengkap,
      this.pekerjaan,
      this.password,
      this.email,
      this.uid,
      this.usia,
      this.noTelp,
      this.domisili,
      this.gender,
      this.image,
      this.status});
  Map<String, dynamic> toJson() {
    return {
      "namaLengkap": namaLengkap,
      "email": email,
      "password": password,
      "pekerjaan": pekerjaan,
      "uid": uid,
      "usia": usia,
      "noTelp": noTelp,
      "status": status,
      "gender": gender,
      "domisili": domisili,
      "image": image,
    };
  }

  factory ModelData.fromJson(Map<String, dynamic> json) {
    return ModelData(
      namaLengkap: json['namaProduct'],
      email: json['email'],
      password: json['penanaman'],
      pekerjaan: json['pekerjaan'],
      uid: json['uid'],
      usia: json['usia'],
      noTelp: json['noTelp'],
      status: json['status'],
      gender: json['gender'],
      domisili: json['domisili'],
      image: json['image'],
    );
  }
}
