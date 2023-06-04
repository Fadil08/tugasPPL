// import 'package:belajar_firebase/widgets/pages/penjadwalan/users/jadwal.dart';
import 'package:belajar_firebase/admin/tambahTanaman/listdata.dart';
import 'package:belajar_firebase/users/penjadwalan/editpenjadwalan.dart';
import 'package:belajar_firebase/users/penjadwalan/service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:belajar_firebase/utils/theme.dart';

import '../../admin/tambahTanaman/databaseTanaman.dart';
import 'dataTahapan.dart';

class MyHomePenjadwalan extends StatefulWidget {
  const MyHomePenjadwalan({super.key});

  @override
  State<MyHomePenjadwalan> createState() => _MyHomePenjadwalanState();
}

class _MyHomePenjadwalanState extends State<MyHomePenjadwalan> {
  final _searchText = TextEditingController();

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _searchText.addListener(getRun);
    super.initState();
  }

  // Future<void> onSearch() {
  //   setState(() {});
  //   // return dataservisTanaman.getData(_searchText.text);
  //   // return dataservisTanaman.getDataTaman(_searchText.text);
  //   // return getSubCollectionData();
  // }
  List<Tanaman> jadwal = [];

  Future<void> getRun() async {
    jadwal = await databaseTanaman.getrun();
    setState(() {});
  }

  int _jumlah = 0;
  final datauser = FirebaseAuth.instance.currentUser;

  final Userlogin = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // if (jadwal.isEmpty) {
              //   // getRun();
              // }
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => listTanaman()));
            },
            backgroundColor: Colors.blueGrey,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            )),
        body: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            width: size.width * 1,
            height: size.height * 0.1,
            child: Text(
              'Penjadwalan',
              style: TextStyle(color: ColorPelatte.fontcolor, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: ColorPelatte.primaryColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchText,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  )),
            ),
          ),
          // IconButton(
          //     onPressed: () {
          //       getRun();
          //     },
          //     icon: Icon(Icons.replay_outlined)),
          Expanded(
            child: FutureBuilder(
                future: getRun(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: jadwal.length,
                      itemBuilder: (context, index) {
                        final data = jadwal[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          dataJadwalTanaman()));
                            },
                            title: Text(data.namaTanaman),
                            subtitle: Text(data.deskripsi),
                            leading: IconButton(
                                onPressed: () {}, icon: Icon(Icons.edit)),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            splashColor: Colors.amber,
                            textColor: Colors.deepPurpleAccent,
                          ),
                        );
                      });
                }),
          )
          // Expanded(
          //     child: ListView.builder(
          //         itemBuilder: (context, index) {
          //           final data = jadwal[index];
          //           return ListTile(
          //             onTap: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => listTanaman()));
          //             },
          //             title: Text(data.namaTanaman),
          //             subtitle: Text(data.deskripsi),
          //             leading: Row(
          //               children: [
          //                 IconButton(
          //                   onPressed: () {
          //                     Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) =>
          //                                 dataJadwalTanaman()));
          //                   },
          //                   icon: Icon(
          //                     Icons.mode_sharp,
          //                     color: ColorPelatte.primarydarkColor,
          //                   ),
          //                 ),
          //                 IconButton(
          //                     onPressed: () {
          //                       dataservisTanaman.hapusDataTanaman(
          //                           judulhapus: data.namaTanaman);
          //                     },
          //                     icon: Icon(
          //                       Icons.delete,
          //                       color: ColorPelatte.primarydarkColor,
          //                     ))
          //               ],
          //             ),
          //           );
          //         },
          //         itemCount: jadwal.length))
        ]));
  }
}
