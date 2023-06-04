import 'package:belajar_firebase/admin/tambahTanaman/databaseTanaman.dart';
import 'package:belajar_firebase/users/penjadwalan/service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/modelsauth.dart';

class MyTest extends StatefulWidget {
  const MyTest({super.key});

  @override
  State<MyTest> createState() => _MyTestState();
}

final data = FirebaseAuth.instance.currentUser;

class _MyTestState extends State<MyTest> {
  List<Tanaman> jadwal = [];

  Future<void> getRun() async {
    dataservisTanaman.gettahapan();
    // jadwal = getrun();
    setState(() {});
  }

  static Future<List<penjadwalanTanaman>> gettahapan() async {
    var commentsRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${data?.email}')
        .collection('penjadwalan')
        .doc()
        .collection('tahapan');
    var querySnapshot = await commentsRef.get();
    print(querySnapshot.docs);
    return querySnapshot.docs
        .map((e) => penjadwalanTanaman.fromJson(e.data()))
        .toList();
  }
  //   List<Tanaman> jadwal = [];

  // Future<void> getRun() async {
  //   jadwal = await databaseTanaman.getrun();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${data?.email}'),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  // gettahapan();
                  dataservisTanaman.gettahapan();
                },
                child: Text("GET")),
            Expanded(
              child: ListView.builder(
                  itemCount: jadwal.length,
                  itemBuilder: (context, index) {
                    final data = jadwal[index];
                    return ListTile(
                      title: Text(data.namaTanaman),
                      subtitle: Text(data.deskripsi),
                    );
                  }),
            )
          ],
        ));
  }
}

// class GetDataTanaman extends StatelessWidget {
//   const GetDataTanaman({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(builder: ((context, Snapshot) {
//       if (Snapshot.connectionState == ConnectionState.done) {
//         Map<String, dynamic> data =
//             Snapshot.data?.data() as Map<String, dynamic>;
//         return Text('${data['namaTanaman']}');
//       }
//       return Text('Loading .....');
//     }));
//   }
// }

// class mytest extends StatelessWidget {
//   const mytest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             dataservisTanaman.getrun();
//           },
//           child: Text("simpan"),
//         ),
//       ),
//     );
//   }
// }
// 
// class subdata extends StatefulWidget {
  
//   _subdataState createState() => _subdataState();
// }

// class _subdataState extends State<subdata> {
//   // Buat instance dari FirebaseFirestore
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
//   // Buat variabel list untuk menampung data dari subcollection
//   List<Map<String, dynamic>> subCollectionDataList = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sub Collection Data'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: FutureBuilder(
//           future: getSubCollectionData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               return ListView.builder(
//                 itemCount: subCollectionDataList.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(subCollectionDataList[index]['title']),
//                     subtitle: Text(subCollectionDataList[index]['subtitle']),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Future<void> getSubCollectionData() async {
//     try {
//       // Ambil referensi dari subcollection
//       final CollectionReference subCollectionRef = firestore
//           .collection('users')
//           .doc('${FirebaseAuth.instance.currentUser?.email}')
//           .collection('penjadwalan');

//       // Baca data dari subcollection
//       final QuerySnapshot querySnapshot = await subCollectionRef.get();

//       // Tambahkan data ke dalam variabel list
//       querySnapshot.docs.forEach((doc) {
//         subCollectionDataList.add(doc.data());
//       });
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }

