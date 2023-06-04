import 'package:cloud_firestore/cloud_firestore.dart';

final tblpengetahuan = FirebaseFirestore.instance.collection("transaksi");

class databaseTrnsaksiAdmin {
  static Stream<QuerySnapshot> getData() {
    return tblpengetahuan.snapshots();
  }
}
