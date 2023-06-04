import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mychat/admin/pembayaran/modelPembayaran.dart';
import 'package:mychat/utils/componen.dart';
import 'package:mychat/utils/notif.dart';
import 'package:mychat/utils/theme.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyAdminPembayaran extends StatefulWidget {
  const MyAdminPembayaran({super.key});

  @override
  State<MyAdminPembayaran> createState() => _MyAdminPembayaranState();
}

final firestrore = FirebaseFirestore.instance;

class _MyAdminPembayaranState extends State<MyAdminPembayaran> {
  final namaBank = TextEditingController();
  final namaakun = TextEditingController();
  final nomerrekening = TextEditingController();
  final deskripsi = TextEditingController();
  final logoakun = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pembayaran'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.name,
              controller: namaakun,
              autocorrect: EditableText.debugDeterministicCursor,
              // maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Nama Akun',
                labelText: 'Nama Akun',
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
              controller: nomerrekening,
              autocorrect: EditableText.debugDeterministicCursor,
              // maxLines: 10,
              decoration: InputDecoration(
                hintText: 'masukkan nomer rekening',
                labelText: 'Nomer Rekening',
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
              controller: namaBank,
              autocorrect: EditableText.debugDeterministicCursor,
              // maxLines: 10,
              decoration: InputDecoration(
                hintText: 'masukkan Nama Bank',
                labelText: 'nama Bank',
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
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'masukkan deskripsi',
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
                fillColor: ColorPelatte.primaryColor,
              ),
            ),
          ),
          Container(
            child: Textfield(
              hintText: "ImageUrl",
              icon: Icons.image,
              onTap: () async {
                logoakun.text = await selectImage(context);
              },
            ),
          ),
          Container(
            width: size.width * 0.3,
            height: size.height * 0.05,
            child: ElevatedButton(
                onPressed: () {
                  DateTime now = DateTime.now();

                  var datate = (now.year.toString() +
                      ":" +
                      now.month.toString() +
                      ":" +
                      now.day.toString());
                  final adddataakunPembayaran = pembayaran(
                      // idPemabayaran:
                      namaAkun: namaakun.text.trim(),
                      deksripsi: deskripsi.text.trim(),
                      namaBank: namaBank.text.trim(),
                      nomerRekening: nomerrekening.text.trim(),
                      imageUrl: logoakun.text.trim(),
                      upDate: datate.toLowerCase().toString());
                  tambahData(item: adddataakunPembayaran);
                },
                child: Row(
                  children: [
                    Icon(Icons.save),
                    Text("save"),
                  ],
                )),
          )
        ],
      ),
    );
  }

  CollectionReference data =
      FirebaseFirestore.instance.collection('akunPembayaran');
  void tambahData({required pembayaran item}) async {
    try {
      DocumentReference docRef = data.doc();
      await docRef
          .set(item.toJson())
          .whenComplete(() => print("data berhasil diinput"))
          .catchError((e) => print(e));
      namaakun.clear();
      namaBank.clear();
      nomerrekening.clear();
      deskripsi.clear();
      logoakun.clear();
      notif()
          .snackbarSucses(context, 'succses', 'Akun bank Berhasil DI inputkan');
      print('sukses');
    } catch (e) {
      print(e);
    }
  }
}
