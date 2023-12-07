import 'dart:io';

import 'package:belajar_firebase/auth/auth.dart';
import 'package:belajar_firebase/users/profile/setdatabasae.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils copy/notif.dart';
import '../../utils/theme.dart';

class MyeditProfileuser extends StatefulWidget {
  final Auth? dataDet;
  // String? namaLengkap, usia, domisili, pekerjaan, gender, number, imageURL;
  MyeditProfileuser({Key? key, this.dataDet}) : super(key: key)
  //   this.namaLengkap,
  // this.usia,
  // this.pekerjaan,
  // this.gender,
  // this.number,,
  // this.domisili,
  // this.imageURL,
  ;

  @override
  State<MyeditProfileuser> createState() => _MyeditProfileuserState();
}

// this.namalengkap,
// this.usia,
// this.email,
// this.password,
// this.pekerjaan,
// this.domisili,
// this.idUser,
class _MyeditProfileuserState extends State<MyeditProfileuser> {
  final namaLengkapControler = TextEditingController();
  final emailControler = TextEditingController();
  final usiaControler = TextEditingController();
  final pekerjaanControler = TextEditingController();
  final domisiliControler = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    emailControler.dispose();
    namaLengkapControler.dispose();
    usiaControler.dispose();
    pekerjaanControler.dispose();
    domisiliControler.dispose();
    super.dispose();
  }

  String? image, number, status;
  @override
  void initState() {
    // TODO: implement initState
    emailControler.text = widget.dataDet?.email ?? "";
    namaLengkapControler.text = widget.dataDet?.namaLengkap ?? '';
    usiaControler.text = widget.dataDet?.usia ?? '';
    pekerjaanControler.text = widget.dataDet?.pekerjaan ?? '';
    domisiliControler.text = widget.dataDet?.domisili ?? '';
    number = widget.dataDet?.noTelp ?? '';
    image = widget.dataDet?.image ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(" Edit Profile"),
        backgroundColor: ColorPelatte.primaryColor,
        centerTitle: true,
      ),
      body: Container(
        color: ColorPelatte.bg,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: ColorPelatte.primaryColor.withOpacity(.2),
                              blurRadius: 10.0)
                        ],
                        borderRadius: BorderRadius.circular(100.0),
                        gradient: LinearGradient(colors: [
                          ColorPelatte.primaryColor,
                          Colors.green.shade900
                        ])),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(image.toString()),
                      // backgroundImage: NetworkImage('$imageURL'),
                      // child: Text('P',
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 40.0,
                      //         fontWeight: FontWeight.bold)),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        image = await selectImage(context);
                      },
                      icon: Icon(
                        Icons.image_search_rounded,
                        // size: 10,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              width: size.width * 1,
              child: Text(
                "Edit",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorPelatte.bg2),
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: emailControler,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Masukkan Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: namaLengkapControler,
                        decoration: InputDecoration(
                          labelText: "Nama Lengkap",
                          hintText: "Masukkan Nama Lengkap",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorPelatte.primarydarkColor),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: usiaControler,
                        decoration: InputDecoration(
                          labelText: "Usia",
                          hintText: "Masukkan Usia",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: pekerjaanControler,
                        decoration: InputDecoration(
                          labelText: "Pekerjaan",
                          hintText: "Masukkan Pekerjaan",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: domisiliControler,
                        decoration: InputDecoration(
                          labelText: "Domisili",
                          hintText: "Masukkan Domisili",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: size.width * 0.6,
                      child: Row(
                        children: [
                          ElevatedButton(
                              // ignore: prefer_const_constructors
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                namaLengkapControler.clear();
                                emailControler.clear();
                                usiaControler.clear();
                                pekerjaanControler.clear();
                                domisiliControler.clear();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.close,
                                  ),
                                  Text("close")
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                final dataSudahDiedit = Auth(
                                    domisili: domisiliControler.text,
                                    email: widget.dataDet?.email,
                                    namaLengkap:
                                        namaLengkapControler.text.trim(),
                                    pekerjaan: pekerjaanControler.text.trim(),
                                    usia: usiaControler.text.trim(),
                                    image: image);
                                tambahData(item: dataSudahDiedit);
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    LineAwesomeIcons.save,
                                  ),
                                  Text("Save")
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future selectImage(context) async {
    final storage = FirebaseStorage.instance;
    String? url;

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

  CollectionReference data = FirebaseFirestore.instance.collection('users');
  void tambahData({required Auth item}) async {
    final auth = FirebaseAuth.instance.currentUser;
    try {
      DocumentReference docRef = data.doc(auth?.uid.toString());
      await docRef
          .set(item.toJson())
          .whenComplete(() => print("data berhasil diinput"))
          .catchError((e) => print(e));
      snackbarSucses(context);
      // snackbarSucses();}
      emailControler.clear();
      domisiliControler.clear();
      emailControler.clear();
      pekerjaanControler.clear();
      usiaControler.clear();
      number = null;
    } catch (e) {
      notif().erorsnackbar(e);
    }
  }
}
