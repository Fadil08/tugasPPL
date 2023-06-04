import 'package:belajar_firebase/models/modelsauth.dart';
import 'package:belajar_firebase/admin/tambahTanaman/databaseTanaman.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/auth.dart';

class penjadwalanTanaman {
  final String namaTanaman;
  final String? tahapan;
  final String? startJadwal;
  final String? endJadwal;
  final String? deskripsi;
  final String? id_user;

  penjadwalanTanaman(
      {required this.namaTanaman,
      this.tahapan,
      this.startJadwal,
      this.endJadwal,
      this.deskripsi,
      this.id_user});
  Map<String, dynamic> toJson() {
    return {
      "namaTanaman": namaTanaman,
      "tahapan": tahapan,
      "startJadwal": startJadwal,
      "endJadwal": endJadwal,
      "deskripsi": deskripsi,
      "id_user": id_user,
    };
  }

  factory penjadwalanTanaman.fromJson(Map<String, dynamic> json) {
    return penjadwalanTanaman(
      namaTanaman: json['namaTanaman'],
      tahapan: json['tahapan'],
      startJadwal: json['startJadwal'],
      endJadwal: json['endJadwal'],
      deskripsi: json['dekripsi'],
      id_user: json['id_user'],
    );
  }
}

CollectionReference loadJadwal =
    FirebaseFirestore.instance.collection('tahapan');

final Userlogin = FirebaseAuth.instance.currentUser;

class dataservisTanaman {
  static Future<void> getrun() async {
    var commentsRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${Userlogin?.email}')
        .collection('penjadwalan');

// Get all documents in the subcollection "comments"
    var querySnapshot = await commentsRef.get();
    querySnapshot.docs.forEach((doc) {
      print(doc.data());
    });
  }

  static Future<List<penjadwalanTanaman>> gettahapan() async {
    var commentsRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${Userlogin?.email}')
        .collection('penjadwalan');
    var querySnapshot = await commentsRef.get();
    print(querySnapshot.docs[0].data());
    return querySnapshot.docs
        .map((e) => penjadwalanTanaman.fromJson(e.data()))
        .toList();
  }

  static Future<List<penjadwalanTanaman>> getruntahapan(
      {required penjadwalanTanaman item}) async {
    var ref = FirebaseFirestore.instance
        .collection('users')
        .doc('${Userlogin?.email}')
        .collection('penjadwalan')
        .get();

    var commentsRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${Userlogin?.email}')
        .collection('penjadwalan')
        .doc()
        .collection('tahapan');
    var querySnapshot = await commentsRef.get();
    return querySnapshot.docs
        .map((e) => penjadwalanTanaman.fromJson(e.data()))
        .toList();
  }

  static Stream<QuerySnapshot> get(String judul) {
    if (judul == "")
      return loadJadwal
          .doc('${Userlogin?.email}')
          .collection('penjadwalan')
          .snapshots();
    else
      return loadJadwal
          .doc('${Userlogin?.email}')
          .collection('penjadwalan')
          .orderBy("namaTanaman")
          // .snapshots();
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  }

  static Stream<QuerySnapshot> getDataTaman(String judul) {
    if (judul == "") {
      return loadJadwal
          .doc('${Userlogin?.email}')
          .collection('penjadwalan')
          .snapshots();
    } else
      return loadJadwal
          .doc('${Userlogin?.email}')
          .collection('penjadwalan')
          .orderBy("namaTanaman")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  }

  Stream<List<Tanaman>> getUserList() {
    return loadJadwal
        .doc('${Userlogin?.email}')
        .collection('penjadwalan')
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) =>
                Tanaman.fromJson(document.data as Map<String, dynamic>))
            .toList());
  }

  static Future<void> tambahDataTanaman(
      {required penjadwalanTanaman item}) async {
    print(Userlogin);
    DocumentReference docRef = loadJadwal
        .doc('${Userlogin?.email}')
        .collection('penjadwalan')
        .doc(item.namaTanaman)
        .collection('tahapan')
        .doc(item.tahapan);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }

  static Future<void> lengkapidatatanaman(
      {required penjadwalanTanaman item}) async {
    DocumentReference docRef = loadJadwal
        .doc('${Userlogin?.email}')
        .collection('penjadwalan')
        .doc(item.namaTanaman)
        .collection('tahapan')
        .doc(item.tahapan);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }

  static Future<void> ubahData({required penjadwalanTanaman item}) async {
    CollectionReference tblPenjadwalan =
        FirebaseFirestore.instance.collection('penjadwalan');
    DocumentReference docRef = tblPenjadwalan.doc(item.namaTanaman);

    await docRef
        .update(item.toJson())
        .whenComplete(() => print("data berhasil di ubah"))
        .catchError((e) => print(e));
  }

  static Future<void> hapusDataTanaman({required String judulhapus}) async {
    DocumentReference docRef = loadJadwal.doc(judulhapus);
    await docRef
        .delete()
        .whenComplete(() => print("data berhasil di hapus"))
        .catchError((e) => print(e));
  }

  static Future<void> hapusDataTahapan(
      {required penjadwalanTanaman judulhapus}) async {
    DocumentReference docRef = loadJadwal
        .doc(judulhapus.namaTanaman)
        .collection('tahapan')
        .doc(judulhapus.tahapan);
    await docRef
        .delete()
        .whenComplete(() => print("data berhasil di hapus"))
        .catchError((e) => print(e));
  }

  static Future<void> getdataTanaman() async {
    print('ok');
    var dataref = FirebaseFirestore.instance
        .collection('tahapan')
        .where('id', isEqualTo: userId?.uid.toString())
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
}
