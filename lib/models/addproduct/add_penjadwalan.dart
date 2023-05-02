// import 'package:belajar_firebase/models/addproduct/controlerAddProduct.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MyTanaman extends StatefulWidget {
//   const MyTanaman({super.key});

//   @override
//   State<MyTanaman> createState() => _MyTanamanState();
// }

// class _MyTanamanState extends State<MyTanaman> {
//   @override
//   final CollectionReference products =
//       FirebaseFirestore.instance.collection('products');
//   Widget build(BuildContext context) {
//     String nametable = 'products';
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tanaman'),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: StreamBuilder(
//             stream: products.snapshots(),
//             builder: (context, AsyncSna pshot<QuerySnapshot> streamSnapshot) {
//               if (streamSnapshot.hasData) {
//                 return ListView.builder(
//                     itemCount: streamSnapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       final DocumentSnapshot documentSnapshot =
//                           streamSnapshot.data!.docs[index];
//                     });
//               }
//             }),
//       ),
//     );
//   }
// }
