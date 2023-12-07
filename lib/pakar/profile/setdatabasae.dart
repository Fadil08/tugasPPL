
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final firestore = FirebaseFirestore.instance;
// final auth = FirebaseAuth.instance.currentUser;
final auth = FirebaseAuth.instance.currentUser!.email;

class databaseProfile {
  static Future<void> ubahData({required databaseProfile item}) async {
    // await docRef
    //     .update(item.toJson())
    //     .whenComplete(() => print("data berhasil di ubah"))
    //     .catchError((e) => print(e));
  }

  Future getInfo() async {
    // var email = auth!.email;
    var datas;
    try {
      final response = await firestore.collection('users').get();
      final data =
          response.docs.where((element) => element['email'] == '').first;
      datas = data;
    } catch (e) {}
    return datas;
  }

  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: "${auth}")
        .snapshots();
  }
}
