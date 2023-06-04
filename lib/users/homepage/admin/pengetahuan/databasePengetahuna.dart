import 'package:cloud_firestore/cloud_firestore.dart';

final tblpengetahuan = FirebaseFirestore.instance.collection("pengetahuan");
List elements = ['Tanaman', 'Pupuk', 'pestisida', 'Hama'];

class databasepengetahuan {
  static Stream<QuerySnapshot> getData(role) {
    return tblpengetahuan
        .where("rolePengetahuan", isEqualTo: "${role}")
        .snapshots();
  }
}
