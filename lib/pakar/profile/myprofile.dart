import 'package:belajar_firebase/auth/auth.dart';
import 'package:belajar_firebase/users/profile/setdatabasae.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../utils copy/theme.dart';
import 'editProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List data = [];
  // datas Auth datas;
  DocumentSnapshot? saveata;
  final auth = FirebaseAuth.instance.currentUser!.email;
  // final email = auth.currentUser!.email;
  final firestore = FirebaseFirestore.instance;
  //  () async {
  //   var datas;
  //   try {

  //     // final data = response.docs.where((element) => firestore)
  //     data = response as List;
  //   } catch (e) {}
  //   // ret;
  // }

  Stream<QuerySnapshot<Object?>> onMyProfile() {
    setState(() {});
    return databaseProfile.getData();
    // return databaseProfile.g
    // return .getData('users', 'pakar');
  }

  @override
  void initState() {
    print(auth);
    // getInfo();
    firestore
        .collection('users')
        .where('uid', isEqualTo: auth)
        .snapshots()
        .map((event) => event.docs.forEach((element) {
              element.data()['namaLengkap'];
              print(element.data().toString());
            }));
    // saveata = response as DocumentSnapshot<Object?>?;

    // print(data.length);
    // getInfo().then((value) {
    //   data = value;

    //   if (mounted) {
    //     setState(() {
    //       print(data);
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPelatte.primaryColor,
          title: Text('Profile Page'),
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: onMyProfile(),
                    builder: (context, snapshot) {
                      // if (ConnectionState.waiting) {
                      //   return CircularProgressIndicator();
                      // }
                      if (snapshot.hasError) {
                        return Center(
                            child:
                                Text('terjadi Kesalahan ${snapshot.hasError}'));
                      }
                      if (snapshot.hasData || snapshot.data != null) {
                        return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8.0),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              // final data = dataChat[index];
                              DocumentSnapshot dsData =
                                  snapshot.data!.docs[index];
                              String nama = dsData['namaLengkap'];
                              String ImageURL = dsData['image'];

                              return Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          width: 100.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: ColorPelatte
                                                        .primaryColor
                                                        .withOpacity(.2),
                                                    blurRadius: 10.0)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              gradient: LinearGradient(colors: [
                                                ColorPelatte.primaryColor,
                                                Colors.green.shade900
                                              ])),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                                dsData['image'].toString()),
                                            // backgroundImage: NetworkImage('$imageURL'),
                                            // child: Text('P',
                                            //     style: TextStyle(
                                            //         color: Colors.white,
                                            //         fontSize: 40.0,
                                            //         fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Container(
                                            height: 55,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    214, 224, 239, 1),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Name: ${dsData['namaLengkap']}',
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 38, 67, 0.82),
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Container(
                                            height: 55,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    214, 224, 239, 1),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'email: ${dsData['email']}',
                                                    // '',
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 38, 67, 0.82),
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Container(
                                            height: 55,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    214, 224, 239, 1),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'pekerjaan: ${dsData['pekerjaan']}',
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 38, 67, 0.82),
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Container(
                                            height: 55,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    214, 224, 239, 1),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'gender: ${dsData['gender']}',
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 38, 67, 0.82),
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Container(
                                            height: 55,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    214, 224, 239, 1),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'domisili: ${dsData['domisili']}',
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 38, 67, 0.82),
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Container(
                                            height: 55,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    214, 224, 239, 1),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'number: ${dsData['noTelp']}',
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 38, 67, 0.82),
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Container(
                                            height: 55,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    214, 224, 239, 1),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Status: ${dsData['status']}',
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            18, 38, 67, 0.82),
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              final dataEdit = Auth(
                                                email: dsData['email'],
                                                namaLengkap:
                                                    dsData['namaLengkap'],
                                                pekerjaan: dsData['pekerjaan'],
                                                gender: dsData['gender'],
                                                usia: dsData['usia'],
                                                domisili: dsData['domisili'],
                                                image: dsData['image'],
                                                noTelp: dsData['noTelp'],
                                                password: dsData['password'],
                                                status: dsData['status'],
                                                uid: dsData['uid'],
                                                addtime: dsData['addtime'],
                                                // noTelp: dsData['noTelp'],
                                              );
                                              print(data);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyeditProfileuser(
                                                            dataDet: dataEdit,
                                                          )));
                                            },
                                            child: Text("edit"))
                                      ],
                                    ),
                                  ));
                            });
                      }
                      return Container();
                    })),
          ],
        ));
  }
}
