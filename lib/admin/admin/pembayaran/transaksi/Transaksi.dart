import 'dart:io';
import 'dart:js_interop';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/theme.dart';
import 'modelpremium.dart';

class tambahPaketPremium extends StatefulWidget {
  const tambahPaketPremium({super.key});

  @override
  State<tambahPaketPremium> createState() => _tambahPaketPremiumState();
}

final firestrore = FirebaseFirestore.instance;

class _tambahPaketPremiumState extends State<tambahPaketPremium> {
  final namaBank = TextEditingController();
  final harga = TextEditingController();
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

  String? _paket;
  List premium = ["1Minggu", "1Bulan", '1Tahun'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pembayaran'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            DropdownButton(
              hint: Text("Select The Premium"),
              value: _paket,
              items: premium.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _paket = value
                      .toString(); //Untuk memberitahu _paket bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                });
              },
            ),
            Text(
              "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                // keyboardAppearance: ,
                controller: harga,
                autocorrect: EditableText.debugDeterministicCursor,
                // maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Harga',
                  labelText: 'Harga',
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
                // autocorrect: EditableText.debugDeterministicCursor,

                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Deskripsi Paket',
                  labelText: 'Deskripsi Paket',
                  border: OutlineInputBorder(),
                  fillColor: ColorPelatte.primaryColor,
                ),
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
                    final adddataakunPembayaran = paketPremium(
                        namaPaket: _paket,
                        deskripsi: deskripsi.text.trim(),
                        jumlahNominal: harga.text.trim(),
                        update: datate.toLowerCase().toString());
                    addData(item: adddataakunPembayaran);
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
      ),
    );
  }

  CollectionReference data =
      FirebaseFirestore.instance.collection('paketPremium');
  void addData({required paketPremium item}) async {
    try {
      DocumentReference docRef = data.doc();
      await docRef
          .set(item.toJson())
          .whenComplete(() => print("data berhasil diinput"))
          .catchError((e) => print(e));
      harga.clear();
      _paket = null;
      deskripsi.clear();
      // logoakun.clear();
      notif().snackbarSucses(
          context, 'succses', 'paket Premium  Berhasil DI inputkan');
      print('sukses');
    } catch (e) {
      print(e);
    }
  }
}
