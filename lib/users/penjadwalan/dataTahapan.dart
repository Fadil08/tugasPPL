import 'package:belajar_firebase/Page_Home.dart';
import 'package:belajar_firebase/users/penjadwalan/editpenjadwalan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'service.dart';

class dataJadwalTanaman extends StatefulWidget {
  const dataJadwalTanaman({Key? key}) : super(key: key);

  @override
  State<dataJadwalTanaman> createState() => _dataJadwalTanamanState();
}

class _dataJadwalTanamanState extends State<dataJadwalTanaman> {
  final _searchText = TextEditingController();


  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _searchText.addListener(onSearch);
    super.initState();
  }
  List<penjadwalanTanaman> jadwal = [];

  Future<void> getRun() async {
    // jadwal = await dataservisTanaman.getruntahapan();
    setState(() {});
  }

  int _jumlah = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tahapan "),
          backgroundColor: Colors.green,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const editdataPenjadwalan()));
            },
            backgroundColor: Colors.blueGrey,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            )),
        body: Container(
          margin: const EdgeInsets.fromLTRB(8, 20, 8, 8),
          child: Column(
            children: [
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
                                  final dtBaru = penjadwalanTanaman(
                                    tahapan: '',
                                    startJadwal: '',
                                    deskripsi: '',
                                    endJadwal: '',
                                    namaTanaman: '',
                                  );
                                  // Database.ubahData(item: dtBaru);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              editdataPenjadwalan(
                                                  dataDet: dtBaru)));
                                },
                                title: Text(''),
                                subtitle: Text(''),
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
              //   child: FutureBuilder(
              //     future: ,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasError) {
              //         return const Text('ERROR');
              //       } else if (snapshot.hasData || snapshot.data != null) {
              //         return ListView.separated(
              //             itemBuilder: (context, index) {
              //               DocumentSnapshot dsData =
              //                   snapshot.data!.docs[index];
              //               String lvJudul = dsData['namaTanaman'];
              //               String lvtahap = dsData['tahapan'];
              //               String lvstart = dsData['startJadwal'];
              //               String lvend = dsData['endJadwal'];
              //               String lvdeskripsi = dsData['deskripsi'];
              //               ;

              //               _jumlah = snapshot.data!.docs.length;
              //               return Padding(
              //                 padding: EdgeInsets.all(10),
              //                 child: ListTile(
              //                   onTap: () {
              //                     final dtBaru = penjadwalanTanaman(
              //                       tahapan: lvtahap,
              //                       startJadwal: lvstart,
              //                       deskripsi: lvdeskripsi,
              //                       endJadwal: lvend,
              //                       namaTanaman: lvJudul,
              //                     );
              //                     // Database.ubahData(item: dtBaru);
              //                     Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                             builder: (context) =>
              //                                 editdataPenjadwalan(
              //                                     dataDet: dtBaru)));
              //                   },
              //                   title: Text(lvtahap),
              //                   subtitle: Text(lvstart + ' sampai ' + lvend),
              //                 ),
              //               );
              //             },
              //             separatorBuilder: (context, index) =>
              //                 const SizedBox(height: 8.0),
              //             itemCount: snapshot.data!.docs.length);
              //       }
              //       return const Center(
              //         child: CircularProgressIndicator(
              //           valueColor: AlwaysStoppedAnimation<Color>(
              //             Colors.pinkAccent,
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ));
  }
}
