import 'package:belajar_firebase/users/profile/widgetappbarr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/theme.dart';

class MyeditProfileuser extends StatefulWidget {
  const MyeditProfileuser({super.key});

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

  @override
  void initState() {
    // TODO: implement initState
    emailControler.text.trim();
    namaLengkapControler.text.trim();
    usiaControler.text.trim();
    pekerjaanControler.text.trim();
    domisiliControler.text.trim();
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
              child: Container(
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
                  child: Text('P',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold)),
                ),
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
                        controller: pekerjaanControler,
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
                              onPressed: () {},
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
}
