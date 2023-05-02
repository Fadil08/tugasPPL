import 'package:belajar_firebase/widgets/pages/penjadwalan/editpenjadwalan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'service.dart';

class dataJadwalTanaman extends StatefulWidget {
  const dataJadwalTanaman({Key? key}) : super(key: key);

  @override
  State<dataJadwalTanaman> createState() => _dataJadwalTanamanState();
}

class _dataJadwalTanamanState extends State<dataJadwalTanaman> {
  final _searchText = TextEditingController();
  // CollectionReference tblPenjadwalan =
  //   FirebaseFirestore.instance.collection('penjadwalan').doc().collection('tahapan').doc().collection();
  static Future<void> tambahData(
      {required penjadwalanTanaman item,
      required penjadwalanTanaman tahapan}) async {
    DocumentReference docRef =
        // DocumentReference docRef = tblPenjadwalan.doc(item);
        FirebaseFirestore.instance
            .collection('penjadwalan')
            .doc(item.namaTanaman)
            .collection(item.toString())
            .doc(tahapan.tahapan);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchText.addListener(onSearch);
    super.initState();
  }

  Stream<QuerySnapshot> onSearch() {
    setState(() {});
    return dataservisTanaman.getDataTahapan(_searchText.text);
  }

  int _jumlah = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("FIREBASE CRUD"),
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
                            String lvtahap = dsData['tahapan'];
                            String lvstart = dsData['startJadwal'];
                            String lvend = dsData['endJadwal'];
                            String lvdeskripsi = dsData['deskripsi'];

                            _jumlah = snapshot.data!.docs.length;
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                onTap: () {
                                  final dtBaru = penjadwalanTanaman(
                                      tahapan: lvtahap,
                                      startJadwal: lvstart,
                                      deskripsi: lvdeskripsi,
                                      endJadwal: lvend,
                                      namaTanaman: lvJudul);
                                  // Database.ubahData(item: dtBaru);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              editdataPenjadwalan(
                                                  dataDet: dtBaru)));
                                },
                                title: Text(lvtahap),
                                subtitle: Text(lvstart + ' sampai ' + lvend),
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
