// // import 'dart:js';

// import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../../theme.dart';
// import '../pageHome.dart';
// import 'jadwal.dart';

// class PagePenjadwalan extends StatefulWidget {
//   const PagePenjadwalan({super.key});

//   @override
//   State<PagePenjadwalan> createState() => _PagePenjadwalanState();
// }

// class _PagePenjadwalanState extends State<PagePenjadwalan> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorPelatte.primaryColor,
//         title: Text(
//           'Gondur - Managemet',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         margin: EdgeInsets.only(top: 10),
//         child: ListView.builder(
//           itemBuilder: (context, Positioned) {
//             return Container(
//               color: Color.fromARGB(255, 255, 255, 255),
//               padding: EdgeInsets.only(bottom: 5),
//               child: Card(
//                 color: ColorPelatte.secondary,
//                 child: ListTile(
//                   splashColor: ColorPelatte.secondary,
//                   leading: Image.asset('images/12.jpg'),
//                   title: Text('Nama'),
//                   subtitle: Text('nama panjang'),
//                   trailing: IconButton(
//                     icon: Icon(
//                       Icons.note_alt_outlined,
//                       color: Colors.black,
//                     ),
//                     onPressed: () {},
//                   ),
//                 ),
//               ),
//             );
//           },
//           itemCount: 5,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return DataTanaman();
//           }));
//         },
//         tooltip: 'Add',
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//           size: 30,
//         ),
//       ),
//     );
//   }
// }

import 'package:belajar_firebase/widgets/pages/penjadwalan/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'databaseTanaman.dart';

class listTanaman extends StatefulWidget {
  final penjadwalanTanaman? dataDet;
  const listTanaman({Key? key, this.dataDet}) : super(key: key);

  @override
  State<listTanaman> createState() => _detDataState();
}

class _detDataState extends State<listTanaman> {
  // final _searchText = TextEditingController();
  // final _namaTanaman = TextEditingController();
  // final _deskripsi = TextEditingController();
  static TextEditingController _searchText = TextEditingController();
  static TextEditingController _namaTanaman = TextEditingController();
  static TextEditingController _deskripsi = TextEditingController();
  bool _isDisabled = false;

  @override
  void dispose() {
    _searchText.dispose();
    _namaTanaman.dispose();
    _deskripsi.dispose();
    _searchText.dispose();
    super.dispose();
  }

  @override
  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {});
    return databaseTanaman.getData(_searchText.text);
  }

  int _jumlah = 0;
  @override
  @override
  void initState() {
    _searchText.addListener(onSearch);
    _namaTanaman.text = widget.dataDet?.namaTanaman ?? "";
    _deskripsi.text = widget.dataDet?.deskripsi ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.dataDet == null) _isDisabled = true;

    return Scaffold(
        appBar: AppBar(
          title: Text('List Tanaman'),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(8, 20, 8, 8),
          child: Column(
            children: [
              TextField(
                controller: _searchText,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    )),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: onSearch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('ERROR');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            DocumentSnapshot dsData =
                                snapshot.data!.docs[index];
                            String lvJudul = dsData['namaTanaman'];
                            String lvdeskripsi = dsData['deskripsi'];

                            _jumlah = snapshot.data!.docs.length;
                            return Padding(
                              padding: EdgeInsets.all(3),
                              child: ListTile(
                                onTap: () {
                                  final dtBaru = penjadwalanTanaman(
                                      tahapan: "",
                                      startJadwal: "",
                                      deskripsi: lvdeskripsi,
                                      endJadwal: "",
                                      namaTanaman: lvJudul);
                                },
                                title: Text(lvJudul),
                                leading: IconButton(
                                    onPressed: () {
                                      final dtBaru = penjadwalanTanaman(
                                          tahapan: "",
                                          startJadwal: "",
                                          deskripsi: lvdeskripsi,
                                          endJadwal: "",
                                          namaTanaman: lvJudul);
                                      dataservisTanaman.tambahData(
                                          item: dtBaru);

                                      // Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.add_box_outlined,
                                      color: Colors.deepPurple.shade600,
                                    )),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8.0),
                          itemCount: snapshot.data!.docs.length);
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.pinkAccent,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
