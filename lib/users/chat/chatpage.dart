import 'package:belajar_firebase/auth/auth.dart';
import 'package:belajar_firebase/coba.dart';
import 'package:belajar_firebase/users/chat/controlerchat.dart';
import 'package:belajar_firebase/users/chat/setchat.dart';
import 'package:belajar_firebase/users/profile/setdatabasae.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'detailobrolan.dart';
import 'modelchat.dart';

class LisContactPakar extends StatefulWidget {
  const LisContactPakar({super.key});

  @override
  State<LisContactPakar> createState() => _LisContactPakarState();
}

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

List<ModelData> dataChat = [];
List<ModelData> start = [];

class _LisContactPakarState extends State<LisContactPakar> {
  Stream<QuerySnapshot<Object?>> onNewChat() {
    // setState(() {});
    return chatControler.getData('users', 'pakar');
  }

  Stream<QuerySnapshot<Object?>> onuser() {
    // setState(() {});
    return chatControler.userlogin();
  }

  Pattern? get search => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: onNewChat(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('terjadi Kesalahan ${snapshot.hasError}'));
                  }
                  if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8.0),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // final data = dataChat[index];
                          DocumentSnapshot dsData = snapshot.data!.docs[index];
                          String nama = dsData['namaLengkap'];
                          String ImageURL = dsData['image'];
                          return StreamBuilder(
                              stream: onuser(),
                              builder: (context, snapshotUser) {
                                if (snapshotUser.hasError) {
                                  return Center(
                                      child: Text(
                                          'terjadi Kesalahan ${snapshotUser.hasError}'));
                                }
                                if (snapshotUser.hasData ||
                                    snapshotUser.data != null) {
                                  DocumentSnapshot datauser =
                                      snapshotUser.data!.docs[index];
                                  return ListTile(
                                    title: Text(nama),
                                    subtitle: Text(datauser['uid']),
                                  );
                                  // return widget(
                                  //   child: Container(
                                  //       padding: const EdgeInsets.all(5.0),
                                  //       child: Card(
                                  //         child: Row(
                                  //           children: [
                                  //             CircleAvatar(
                                  //                 backgroundImage: NetworkImage(
                                  //                     "${ImageURL}")),
                                  //             Text(dsData['namaLengkap']),
                                  //             Text('${auth.currentUser?.uid}')
                                  //           ],
                                  //         ),
                                  //       )),
                                  // );
                                }
                                return Container();
                              });
                        });
                  }
                  return Container();
                })),
      ],
    ));
  }
}
