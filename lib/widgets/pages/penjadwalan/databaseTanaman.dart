// // // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Tanaman {
  final String namaTanaman;
  final String pemilihanBibit;
  final String pemupukan;
  final String penanaman;
  final String deskripsi;
  final String pengairan;
  final String pengolahanTanah;
  final String hama;
  Tanaman({
    required this.namaTanaman,
    required this.pengairan,
    required this.pemupukan,
    required this.deskripsi,
    required this.penanaman,
    required this.pemilihanBibit,
    required this.pengolahanTanah,
    required this.hama,
  });
  Map<String, dynamic> toJson() {
    return {
      "namaTanaman": namaTanaman,
      "pemilihanBibit": pemilihanBibit,
      "pemupukan": pemupukan,
      "penanaman": penanaman,
      "pemilihanBibit": pemilihanBibit,
      "deskripsi": deskripsi,
      "pengolahanTanah": pengolahanTanah,
      "hama": hama
    };
  }

  factory Tanaman.fromJson(Map<String, dynamic> json) {
    return Tanaman(
        namaTanaman: json['namaProduct'],
        pemilihanBibit: json['pemilihanBibit'],
        deskripsi: json['dekripsi'],
        pemupukan: json['pemupukan'],
        penanaman: json['penanaman'],
        hama: json['hama'],
        pengairan: json['pengairan'],
        pengolahanTanah: json['pengolahanTanah']);
  }
}

CollectionReference tbltanaman =
    FirebaseFirestore.instance.collection('tanaman');

class databaseTanaman {
  static Stream<QuerySnapshot> getData(String judul) {
    if (judul == "")
      return tbltanaman.snapshots();
    else
      return tbltanaman
          // .where(isEqualTo: judul)
          .orderBy("namaTanaman")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
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
}
