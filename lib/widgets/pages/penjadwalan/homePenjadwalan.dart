import 'package:belajar_firebase/widgets/pages/penjadwalan/dataTahapan.dart';
import 'package:belajar_firebase/widgets/pages/penjadwalan/jadwal.dart';
import 'package:belajar_firebase/widgets/pages/penjadwalan/listdata.dart';
import 'package:belajar_firebase/widgets/pages/penjadwalan/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:belajar_firebase/theme.dart';

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
    _searchText.addListener(onSearch);
    super.initState();
  }

  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {});
    return dataservisTanaman.getData(_searchText.text);
  }

  // static Stream<QuerySnapshot> getData(String judul) {
  //   CollectionReference tblPenjadwalan =
  //       FirebaseFirestore.instance.collection('penjadwalan');
  //   if (judul == "")
  //     return tblPenjadwalan.snapshots();
  //   else
  //     return tblPenjadwalan
  //         // .where(isEqualTo: judul)
  //         .orderBy("namaTanaman")
  //         .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  // }

  int _jumlah = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DataTanaman()));
          },
          backgroundColor: Colors.blueGrey,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          )),
      body: Column(
        children: [
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: onSearch(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('ERROR');
                } else if (snapshot.hasData || snapshot.data != null) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        DocumentSnapshot dsData = snapshot.data!.docs[index];
                        String lvJudul = dsData['namaTanaman'];
                        _jumlah = snapshot.data!.docs.length;
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => dataJadwalTanaman()));
                          },
                          title: Text(lvJudul),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8.0),
                      itemCount: snapshot.data!.docs.length);
                }
                return Center(
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
    );
  }
}
