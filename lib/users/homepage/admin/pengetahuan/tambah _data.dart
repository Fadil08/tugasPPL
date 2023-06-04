import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mychat/admin/pengetahuan/modelDataTananama.dart';
import 'package:mychat/utils/componen.dart';
import 'package:mychat/utils/notif.dart';
import 'package:mychat/utils/theme.dart';

class TambahPengetahuan extends StatefulWidget {
  const TambahPengetahuan({super.key});

  @override
  State<TambahPengetahuan> createState() => _TambahPengetahuanState();
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

String? acceptRole;
List pilihMenu = ["Tanaman", "Pupuk", "Pestisida", "Hama"];
var maxlenght = 1000;

class _TambahPengetahuanState extends State<TambahPengetahuan> {
  final namaPengetahuan = TextEditingController();
  final deskripsi = TextEditingController();
  final cara_pemakaian = TextEditingController();
  final imageURL = TextEditingController();
  var date = DateTime.now();
  String? id_tanaman;
  var id = RangeValues(1, 1000);

  void addData() {
    final upData = Pengetahuan(
        idPengetahuan: id.toString(),
        namaPengetahuan: namaPengetahuan.text.trim(),
        deksripsi: deskripsi.text.trim(),
        dateUP: date.timeZoneName,
        infoPemakaian: cara_pemakaian.text.trim(),
        rolePengetahuan: acceptRole,
        imageUrl: imageURL.text.trim());
    tambahData(item: upData);
  }

  @override
  void dispose() {
    super.dispose();
    namaPengetahuan.dispose();
    cara_pemakaian.dispose();
    deskripsi.dispose();
    imageURL.dispose();
  }

  void snackbarSucses(BuildContext context) {
    AnimatedSnackBar.rectangle(
      'Success',
      'This is a success Updata in Apps',
      type: AnimatedSnackBarType.success,
      brightness: Brightness.dark,
    ).show(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data pengetahuna"),
        centerTitle: true,
        backgroundColor: ColorPelatte.primaryColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: ColorPelatte.bg,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                margin: EdgeInsets.only(bottom: 10),
                width: size.width * 1,
                height: size.height * 0.15,
                child: Text(
                  "Tambah Data Pengetahuan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: ColorPelatte.fontcolor1),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: ColorPelatte.primaryColor)),
            Text(
              "Role Pengetahuan",
              style: TextStyle(
                  color: Color.fromARGB(255, 77, 76, 76),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(top: 4, left: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              width: size.width * 0.5,
              height: size.height * 0.05,
              child: DropdownButton(
                dropdownColor: Colors.green,
                iconEnabledColor: Colors.white,
                value: acceptRole,
                items: pilihMenu.map((value) {
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
                    acceptRole = value as String?;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: namaPengetahuan,
                // maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Nama Tanaman',
                  labelText: 'Nama Tanaman',
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
                controller: deskripsi,
                autocorrect: EditableText.debugDeterministicCursor,
                // maxLines: 10,
                maxLength: maxlenght,

                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'deskripsi',
                  labelText: 'dekripsi',
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
                controller: cara_pemakaian,
                decoration: InputDecoration(
                  hintText: 'cara Pemakaian',
                  labelText: 'Cara Pemakaian',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Textfield(
              hintText: "ImageUrl",
              icon: Icons.image,
              onTap: () async {
                imageURL.text = await selectImage(context);
              },
            ),
            ElevatedButton.icon(
                onPressed: () {
                  addData();
                },
                icon: Icon(Icons.save),
                label: Text("saveed"))
          ]),
        ),
      ),
    );
  }

  CollectionReference data =
      FirebaseFirestore.instance.collection('pengetahuan');
  void tambahData({required Pengetahuan item}) async {
    try {
      DocumentReference docRef = data.doc();
      await docRef
          .set(item.toJson())
          .whenComplete(() => print("data berhasil diinput"))
          .catchError((e) => print(e));
      snackbarSucses(context);
      // snackbarSucses();}
      namaPengetahuan.clear();
      cara_pemakaian.clear();
      deskripsi.clear();
      imageURL.clear();
    } catch (e) {
      notif().erorsnackbar(e);
    }
  }
}
