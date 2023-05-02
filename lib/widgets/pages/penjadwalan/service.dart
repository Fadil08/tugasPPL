// // // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class penjadwalanTanaman {
  final String namaTanaman;
  final String tahapan;
  final String startJadwal;
  final String endJadwal;
  final String deskripsi;
  penjadwalanTanaman({
    required this.namaTanaman,
    required this.tahapan,
    required this.startJadwal,
    required this.endJadwal,
    required this.deskripsi,
  });
  Map<String, dynamic> toJson() {
    return {
      "namaTanaman": namaTanaman,
      "tahapan": tahapan,
      "startJadwal": startJadwal,
      "endJadwal": endJadwal,
      "deskripsi": deskripsi
    };
  }

  factory penjadwalanTanaman.fromJson(Map<String, dynamic> json) {
    return penjadwalanTanaman(
        namaTanaman: json['namaProduct'],
        tahapan: json['tahapan'],
        deskripsi: json['dekripsi'],
        startJadwal: json['startJadwal'],
        endJadwal: json['endJadwal']);
  }
}

// // CollectionReference tblPenjadwalan2 =
// //     FirebaseFirestore.instance.collection('penjadwalan');
// CollectionReference tbltanaman =
//     FirebaseFirestore.instance.collection('tanaman');

class dataservisTanaman {
  static Stream<QuerySnapshot> getDataTahapan(String judul) {
    CollectionReference _docRef = FirebaseFirestore.instance
        .collection('penjadwalan')
        .doc()
        .collection(judul);
    if (judul == "") {
      return _docRef.snapshots();
    } else
      return _docRef
          .orderBy("namaTanaman")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  }

  static Stream<QuerySnapshot> getData(String judul) {
    CollectionReference tblPenjadwalan = FirebaseFirestore.instance
        .collection('penjadwalan')
        .doc()
        .collection(judul);
    if (judul == "")
      return tblPenjadwalan.snapshots();
    else
      return tblPenjadwalan
          .orderBy("namaTanaman")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  }

  static Future<void> tambahData({required penjadwalanTanaman item}) async {
    CollectionReference tblPenjadwalan = FirebaseFirestore.instance
        .collection('penjadwalan')
        .doc()
        .collection(item.namaTanaman);
    DocumentReference docRef = tblPenjadwalan.doc(item.namaTanaman);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }

  static Future<void> ubahData({required penjadwalanTanaman item}) async {
    CollectionReference tblPenjadwalan = FirebaseFirestore.instance
        .collection('penjadwalan')
        .doc()
        .collection(item.namaTanaman);
    DocumentReference docRef = tblPenjadwalan.doc(item.namaTanaman);

    await docRef
        .update(item.toJson())
        .whenComplete(() => print("data berhasil di ubah"))
        .catchError((e) => print(e));
  }

  static Future<void> hapusData({required String judulhapus}) async {
    CollectionReference tblPenjadwalan = FirebaseFirestore.instance
        .collection('penjadwalan')
        .doc()
        .collection(judulhapus);
    DocumentReference docRef = tblPenjadwalan.doc(judulhapus);

    await docRef
        .delete()
        .whenComplete(() => print("data berhasil di hapus"))
        .catchError((e) => print(e));
  }

  // static Stream<QuerySnapshot> getDataPenjadwalan(String judul) {
  //   if (judul == "")
  //     return tblPenjadwalan.snapshots();
  //   else
  //     return tblPenjadwalan
  //         // .where(isEqualTo: judul)
  //         .orderBy("namaTanaman")
  //         .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  // }
}
