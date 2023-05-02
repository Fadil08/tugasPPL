import 'package:cloud_firestore/cloud_firestore.dart';

class controlerProduct {
  Future addproduct() async {}
  Future<void> showproduct() async {
    final CollectionReference products =
        FirebaseFirestore.instance.collection('products');
  }
}
