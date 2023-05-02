// import 'package:belajar_firebase/widgets/pages/penjadwalan/pagedescripsiont.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// // import 'package:gondurapps/widget/pages/penjadwalan/pagedescripsiont.dart';


// class DataTanaman extends StatefulWidget {
//   const DataTanaman({super.key});

//   @override
//   State<DataTanaman> createState() => _DataTanamanState();
// }

// Map<String, dynamic> getdata = {};
// Future getdocid() async {
//   await FirebaseFirestore.instance
//       .collection("Tanaman")
//       .get()
//       .then((snapshot) => snapshot.docs.forEach((element) {
//             print(element.reference);
//           }));
// }


// class _DataTanamanState extends State<DataTanaman> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Tanaman"),
//         ),
//         body: Container(
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemBuilder: (context, Positioned) {
//                     return Container(
//                       // padding: EdgeInsets.only(bott),
//                       child: Card(
//                         color: Colors.amber,
//                         child: ListTile(
//                           leading: Image.asset('images/12.jpg'),
//                           title: Text('Cabe'),
//                           subtitle: Text('description'),
//                           trailing: IconButton(
//                             onPressed: () {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) {
//                                 return Mydescriptions();
//                               }));
//                             },
//                             icon: Icon(Icons.add),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   itemCount: 20,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
import 'package:belajar_firebase/widgets/pages/penjadwalan/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'databaseTanaman.dart';

class DataTanaman extends StatefulWidget {
  final penjadwalanTanaman? dataDet;
  const DataTanaman({Key? key, this.dataDet}) : super(key: key);

  @override
  State<DataTanaman> createState() => _detDataState();
}

class _detDataState extends State<DataTanaman> {
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
