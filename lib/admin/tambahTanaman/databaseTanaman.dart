// // // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Tanaman {
  final String namaTanaman;

  final String deskripsi;
  // final String pengolahanTanah;
  // final String hama;
  Tanaman({
    required this.namaTanaman,
    required this.deskripsi,
  });
  Map<String, dynamic> toJson() {
    return {
      "namaTanaman": namaTanaman,
      "deskripsi": deskripsi,
    };
  }

  factory Tanaman.fromJson(Map<String, dynamic> json) {
    return Tanaman(
        namaTanaman: json['namaTanaman'], deskripsi: json['deskripsi']);
  }
}

CollectionReference tbltanaman =
    FirebaseFirestore.instance.collection('tanaman');
CollectionReference loadJadwal = FirebaseFirestore.instance.collection('users');
final Userlogin = FirebaseAuth.instance.currentUser;

class databaseTanaman {
  Stream<List<Tanaman>> readData() => FirebaseFirestore.instance
      .collection("tanaman")
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => Tanaman.fromJson(doc.data())).toList());

  static Stream<QuerySnapshot> getData(judul) {
    if (judul == "")
      return tbltanaman.snapshots();
    else {
      return tbltanaman
          // .where(isEqualTo: judul)
          .orderBy("namaTanaman")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
    }
  }

  static Future<List<Tanaman>> getrun() async {
    var commentsRef = FirebaseFirestore.instance
        .collection('users')
        .where("uid", isNotEqualTo: Userlogin?.uid)
        .where("status", isEqualTo: "user");
    var querySnapshot = await commentsRef.get();
    return querySnapshot.docs.map((e) => Tanaman.fromJson(e.data())).toList();
  }

  static Future<void> tambahData({required Tanaman item}) async {
    DocumentReference docRef = tbltanaman.doc(item.namaTanaman);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }

  static Future<void> ubahData({required Tanaman item}) async {
    DocumentReference docRef = tbltanaman.doc(item.namaTanaman);

    await docRef
        .update(item.toJson())
        .whenComplete(() => print("data berhasil di ubah"))
        .catchError((e) => print(e));
  }

  static Future<void> hapusData({required String judulhapus}) async {
    DocumentReference docRef = tbltanaman.doc(judulhapus);

    await docRef
        .delete()
        .whenComplete(() => print("data berhasil di hapus"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> getDataPenjadwalan(String judul) {
    if (judul == "")
      return tbltanaman.snapshots();
    else
      return tbltanaman
          // .where(isEqualTo: judul)
          .orderBy("namaTanaman")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  }

  static Future<void> tambahDataTanaman({required Tanaman item}) async {
    print(Userlogin);
    DocumentReference docRef = loadJadwal
        .doc('${Userlogin?.email}')
        .collection('penjadwalan')
        .doc(item.namaTanaman);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }
}

void snackbarSucses(contex) {
  AnimatedSnackBar.rectangle(
    'sucses',
    'This is data success in appand',
    type: AnimatedSnackBarType.success,
    brightness: Brightness.dark,
  ).show(contex);
}
