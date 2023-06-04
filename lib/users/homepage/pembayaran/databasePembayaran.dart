import 'package:cloud_firestore/cloud_firestore.dart';

final tblakunpembayaran =
    FirebaseFirestore.instance.collection("akunPembayaran");

class databaseakunPembayaran {
  static Stream<QuerySnapshot> getData(collection) {
    return FirebaseFirestore.instance.collection(collection)
        // .where("rolePengetahuan", isEqualTo: "${role}")
        .snapshots();
  }
}
