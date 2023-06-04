import 'package:belajar_firebase/users/penjadwalan/service.dart';
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
    super.dispose();
  }

  @override
  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {});
    return databaseTanaman.getData(_searchText);
  }

  int _jumlah = 0;
  @override
  @override
  void initState() {
    // _searchText.addListener(onSearch);
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
                                  final dtBaru = Tanaman(
                                    namaTanaman: lvJudul,
                                    deskripsi: lvdeskripsi,
                                  );
                                  databaseTanaman.tambahDataTanaman(
                                      item: dtBaru);
                                },
                                title: Text(lvJudul),
                                leading: IconButton(
                                    onPressed: () {
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


  // FirebaseFirestore _data = FirebaseFirestore.instance.collection('tanaman');
  // if (judul == "")
  //   return tbltanaman.snapshots();
  // else
  //   return tbltanaman
  //       // .where(isEqualTo: judul)
  //       .orderBy("namaTanaman")
  //       .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  // Stream<List<Data>> readData() => FirebaseFirestore.instance
  //   .collection("data_asupan_vitamin_hewan_ternak")
  //   .snapshots()
  //   .map((snapshots) =>
  //       snapshots.docs.map((doc) => Data.fromJson(doc.data())).toList());

