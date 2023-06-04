import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:belajar_firebase/auth/landingPage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_alert_dialog/models/alert_dialog_text.dart';
import 'package:smart_alert_dialog/smart_alert_dialog.dart';

import '../Page_Home.dart';
import '../admin/authAdmin/loginAdmin.dart';
import '../users/penjadwalan/homePenjadwalan.dart';
import 'Page_SIgnIn.dart';

class Auth {
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
  String? addtime;

  Auth(
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
      this.addtime,
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
      "addtime": addtime,
    };
  }

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
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
      addtime: json['addtime'],
    );
  }
}

List<Auth> dataAuth = [];
CollectionReference Authdata = FirebaseFirestore.instance.collection('user');
final userId = FirebaseAuth.instance.currentUser;

class databaseAuth {
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
  // static void tambahId({required Auth item}) async {
  //   // var id = FirebaseFirestore.instance.collection("users").;
  //   var setdata = FirebaseFirestore.instance.collection("users");
  //   await setdata
  //       .set(item.toJson())
  //       .whenComplete(() => print("data berhasil diinput"))
  //       .catchError((e) => print(e));
  // }

  void fethcdatauser() async {
    QuerySnapshot<Map<String, dynamic>> usrdataloc =
        await FirebaseFirestore.instance.collection('users').get();

    dataAuth = usrdataloc.docs
        .map((doc) => Auth(
            // uid: doc.id,
            namaLengkap: doc.data()['namaLengkap'],
            pekerjaan: doc.data()['pekerjaan'],
            email: doc.data()['email'],
            gender: doc.data()['gender'],
            noTelp: doc.data()['phone'],
            password: doc.data()['password'],
            status: doc.data()['status']))
        .toList();
    // notifyListeners();
  }

  static Future<void> getdataUser() async {
    var setdata = FirebaseFirestore.instance
        .collection("users")
        .where("status", isEqualTo: "user")
        .get();

    var query = await setdata;
    var result = query.docs
        .map((e) => Auth(
            namaLengkap: e.data()['namaLengkap'],
            pekerjaan: e.data()['pekerjaan'],
            email: e.data()['email'],
            gender: e.data()['gender'],
            noTelp: e.data()['phone'],
            password: e.data()['password'],
            usia: e.data()['usia'],
            status: e.data()["status"]))
        .toList();
  }

  static Future<void> tambahdataId({required Auth item}) async {
    // print(Userlogin);
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc();

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }

  static Future<void> getstatus({required Auth item}) async {
    print('ok');
    var dataref = FirebaseFirestore.instance
        .collection('tahapan')
        .where('status', isEqualTo: "user")
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        // print(doc.data());
        print('${doc.id} => ${doc.data}');
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  build(BuildContext context) {
    void LOGIN(email, password) async {
      void snackbarSucses() {
        AnimatedSnackBar.rectangle(
          'Success',
          'This is a success Login in Apps',
          type: AnimatedSnackBarType.success,
          brightness: Brightness.dark,
        ).show(context);
      }

      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  snackbarSucses(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyHomePenjadwalan();
                      },
                    ),
                  ),
                });
        FirebaseFirestore.instance.collection('user');
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
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

  // static Stream<QuerySnapshot> getData(String id) {
  //   if (id == "")
  //     return Authdata.snapshots();
  //   else
  //     return Authdata.orderBy("id")
  //         .startAt([id]).endAt([id + '\uf8ff']).snapshots();
  // }

  static Future<void> tambahData({required Auth item}) async {
    DocumentReference docRef = Authdata.doc(item.email);
    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));

    snackbarSucses;
  }
}

void snackbarSucses(BuildContext context) {
  AnimatedSnackBar.rectangle(
    'Success',
    'This is a success Login in Apps',
    type: AnimatedSnackBarType.success,
    brightness: Brightness.dark,
  ).show(
    context,
  );
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var status;

  getstatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      status = pref.getString("status") ?? "Status not fond";
    });
  }

  @override
  void initState() {
    getstatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageMain();
          } else if (status == "admin") {
            return pageLoginAdmin();
          } else if (status == 'user' || status == 'suplier') {
            return pageLogin();
          } else {
            return MyLandingPage();
          }
        },
      ),
    );
  }
}
