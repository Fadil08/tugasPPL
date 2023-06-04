import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/homepage/penjadwalan/modelPenjadwalan.dart';

final Firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance.currentUser;
List kondisi_tanaman = [
  "active",
];

class databasePenjadwalan {
  static Stream<QuerySnapshot> getPenjadwalan(role) {
    return Firestore.collection("penjadwalan")
        .where("iduser", isEqualTo: auth?.uid)
        .where("roleTanaman", isEqualTo: role)
        .snapshots();
  }

  static Stream<QuerySnapshot> getTanamanTerdata(role) {
    return Firestore.collection("Tanaman")
        .where("roleTanaman", isEqualTo: role)
        .snapshots();
  }

  static Future<void> tambahDataTanaman({required Penjadwalan item}) async {
    print(auth?.uid);
    await Firestore.collection("penjadwalan")
        .doc()
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }

  static Future<List<Penjadwalan>> fetchPenjadwalans() async {
    final usersSnapshot =
        await FirebaseFirestore.instance.collection('Users').get();
    final ordersSnapshot =
        await FirebaseFirestore.instance.collection('Tanaman').get();
    final Penjadwalansnap =
        await FirebaseFirestore.instance.collection('penjadwalan').get();

    final Penjadwalans = <Penjadwalan>[];

    for (final orderDoc in ordersSnapshot.docs) {
      final Tanaman = orderDoc.data();
      final userId = Tanaman[
          'userID']; // Assuming 'user' field contains the user reference

      final userDoc = usersSnapshot.docs.firstWhere((doc) => doc.id == userId);
      final userData = userDoc.data();

      final userOrder = Penjadwalan(idTanaman: userId, deksripsi: userData[""]
          // userName: userData['name'],
          // orderId: orderDoc.id,
          // orderName: Tanaman['name'],
          );

      Penjadwalans.add(userOrder);
    }

    return Penjadwalans;
  }
}
