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

import 'modelTanaman.dart';

class TambahTanamanTerjadwal extends StatefulWidget {
  const TambahTanamanTerjadwal({super.key});

  @override
  State<TambahTanamanTerjadwal> createState() => _TambahTanamanTerjadwalState();
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
List pilihMenu = ["Hias", "Pertanian"];
var maxlenght = 1000;

class _TambahTanamanTerjadwalState extends State<TambahTanamanTerjadwal> {
  final namaTanaman = TextEditingController();
  final deskripsi = TextEditingController();
  final cara_pemakaian = TextEditingController();
  final imageURL = TextEditingController();
  final deskripsiCarapenanaman = TextEditingController();
  var date = DateTime.timestamp().toString();
  var perawatan1 = TextEditingController();
  var wktPengolahanTanah = TextEditingController();
  var wktpemupukan = TextEditingController();
  var wktPenyiraman = TextEditingController();
  var wktPerawatan2 = TextEditingController();
  var rangePenanaman = TextEditingController();
  var perawatan3 = TextEditingController();
  var wktPanen = TextEditingController();
  var wkkInseksida = TextEditingController();
  var wktTanam = TextEditingController();
  var deskripsiPerawatan1 = TextEditingController();
  var deskripsiPerawatan2 = TextEditingController();
  var deskripsiPerawatan3 = TextEditingController();
  String? id_tanaman3;

  void addData() {
    final upData = Tanaman(
        idTanaman: date,
        namaTanaman: namaTanaman.text.trim(),
        deksripsi: deskripsi.text.trim(),
        upDate: "${DateTime.now()}",
        roleTanaman: acceptRole,
        wktperawatan1: int.parse(perawatan1.text),
        wktPerawatan2: int.parse(wktPerawatan2.text),
        wkkInseksida: int.parse(wkkInseksida.text),
        wktperawatan3: int.parse(perawatan3.text),
        deskripsiCarapenanaman: deskripsiCarapenanaman.text,
        wktPengolahanTanah: int.parse(wktPengolahanTanah.text),
        wktpemupukan: int.parse(wktpemupukan.text),
        wktPenyiraman: int.parse(wktPenyiraman.text),
        wktPanen: int.parse(wktPanen.text),
        rangePenanaman: int.parse(rangePenanaman.text),
        deskripsiPerawatan1: deskripsiPerawatan1.text.trim(),
        deskripsiPerawatan2: deskripsiPerawatan2.text.trim(),
        deskripsiPerawatan3: deskripsiPerawatan3.text.trim(),
        imageUrl: imageURL.text.trim());

    tambahData(item: upData);
  }

  @override
  void dispose() {
    super.dispose();
    namaTanaman.dispose();
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
            SizedBox(
              height: size.height * 0.1,
            ),
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
                controller: namaTanaman,
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
            Text(
              "perhitungan waktu Penanaman - panen",
              style: TextStyle(
                  color: Color.fromARGB(255, 77, 76, 76),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Container(
              width: size.width * 1,
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: TextFormField(
                      controller: wktPengolahanTanah,
                      decoration: InputDecoration(
                          hintText: "wkt olah tanah",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: TextFormField(
                      controller: rangePenanaman,
                      decoration: InputDecoration(
                          hintText: "penanama",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * 1,
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: TextFormField(
                      controller: wktTanam,
                      decoration: InputDecoration(
                          hintText: "wkt Penanaman",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: TextFormField(
                      controller: wktPenyiraman,
                      decoration: InputDecoration(
                          hintText: "pengairan",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * 1,
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: TextFormField(
                      controller: perawatan1,
                      decoration: InputDecoration(
                          hintText: "wkt perawatan1",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: TextFormField(
                      controller: wktPerawatan2,
                      decoration: InputDecoration(
                          hintText: "perawatan2",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * 1,
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: TextFormField(
                      controller: perawatan3,
                      decoration: InputDecoration(
                          hintText: "wkt perawatan3",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: TextFormField(
                      controller: wkkInseksida,
                      decoration: InputDecoration(
                          hintText: "inseksida",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * 1,
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: TextFormField(
                      controller: wktpemupukan,
                      decoration: InputDecoration(
                          hintText: "wkt pemupukan",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: TextFormField(
                      controller: wktPanen,
                      decoration: InputDecoration(
                          hintText: "wkt panen",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: deskripsiCarapenanaman,
                autocorrect: EditableText.debugDeterministicCursor,
                // maxLines: 10,
                maxLength: maxlenght,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'deskripsi Tambahan',
                  labelText: 'dekripsiTambahan',
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
                controller: deskripsiPerawatan1,
                autocorrect: EditableText.debugDeterministicCursor,
                // maxLines: 10,
                maxLength: maxlenght,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'deskripsi pewawatan1',
                  labelText: 'deskripsi pewawatan1',
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
                controller: deskripsiPerawatan2,
                autocorrect: EditableText.debugDeterministicCursor,
                // maxLines: 10,
                maxLength: maxlenght,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'deskripsi perawatan2',
                  labelText: 'dekripsi pwawatan2',
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
                controller: deskripsiPerawatan3,
                autocorrect: EditableText.debugDeterministicCursor,
                // maxLines: 10,
                maxLength: maxlenght,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'deskripsi perawatan3',
                  labelText: 'deskripsi Pewawatan3',
                  border: OutlineInputBorder(),
                  fillColor: ColorPelatte.primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 10,
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

  CollectionReference data = FirebaseFirestore.instance.collection('Tanaman');
  void tambahData({required Tanaman item}) async {
    try {
      DocumentReference docRef = data.doc();
      await docRef
          .set(item.toJson())
          .whenComplete(() => print("data berhasil diinput"))
          .catchError((e) => print(e));
      snackbarSucses(context);
      // snackbarSucses();}
      namaTanaman.clear();
      cara_pemakaian.clear();
      deskripsi.clear();
      imageURL.clear();
      cara_pemakaian.clear();
      deskripsiCarapenanaman.clear();
      perawatan1.clear();
      perawatan3.clear();
      wktPanen.clear();
      wktPerawatan2.clear();
      wkkInseksida.clear();
      wktPengolahanTanah.clear();
      wktTanam.clear();
      wktPenyiraman.clear();
      wktpemupukan.clear();
      rangePenanaman.clear();
      deskripsiPerawatan1.clear();
      deskripsiPerawatan2.clear();
      deskripsiPerawatan3.clear();
    } catch (e) {
      notif().erorsnackbar(e);
    }
  }
}
