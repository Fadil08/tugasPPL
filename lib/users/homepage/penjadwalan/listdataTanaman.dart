import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:mychat/homepage/penjadwalan/modelPenjadwalan.dart';
import 'package:mychat/util.dart';
import 'package:mychat/utils/theme.dart';
import 'package:mychat/homepage/penjadwalan/databasePenjadwalan.dart';

class listDataTanamanTerdata extends StatefulWidget {
  const listDataTanamanTerdata({super.key});

  @override
  State<listDataTanamanTerdata> createState() => _listDataTanamanTerdataState();
}

class _listDataTanamanTerdataState extends State<listDataTanamanTerdata> {
  final _searchText = TextEditingController();

  Stream<QuerySnapshot<Object?>> onSearch(role) {
    setState(() {});
    return databasePenjadwalan.getTanamanTerdata(role);
  }

  int _jumlah = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('List Data Tanaman'),
        backgroundColor: ColorPelatte.primaryColor,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => TambahPengetahuan()));
          },
          child: Icon(Icons.add)),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: ColorPelatte.bg,
        width: size.width * 1,
        height: size.height * 1,
        child: ContainedTabBarView(
          tabs: [
            Text(
              'Tanaman Hias',
              style: TextStyle(
                  color: ColorPelatte.underlineTextField,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Pertanian',
              style: TextStyle(
                  color: ColorPelatte.underlineTextField,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ],
          views: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: onSearch('Hias'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('null');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot dsData = snapshot.data!.docs[index];
                          String lvJudul = dsData['namaTanaman'];
                          String role = dsData['roleTanaman'];
                          String image = dsData['imageURL'];
                          String idTanaman = dsData['idTanaman'];
                          _jumlah = snapshot.data!.docs.length;
                          return Padding(
                            padding: EdgeInsets.all(3),
                            child: ListTile(
                                onTap: () {
                                  final tambahdataTanaman = Penjadwalan(
                                      idTanaman: idTanaman,
                                      statusJadwal: "false",
                                      iduser: auth?.uid,
                                      imageUrl: image,
                                      namaTanaman: lvJudul,
                                      roleTanaman: role);
                                  tambahDataTanaman(item: tambahdataTanaman);
                                },
                                title: Text(lvJudul),
                                iconColor: ColorPelatte.colorwhite,
                                leading: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.2,
                                  child: CircleAvatar(
                                      backgroundImage: NetworkImage(image)),
                                )),
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: onSearch('Pertanian'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('null');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot dsData = snapshot.data!.docs[index];
                          String namaTanaman = dsData['namaTanaman'];
                          String role = dsData['roleTanaman'];
                          String image = dsData['imageURL'];
                          String idTanaman = dsData["idTanaman"];

                          _jumlah = snapshot.data!.docs.length;
                          return Padding(
                            padding: EdgeInsets.all(3),
                            child: ListTile(
                                onTap: () {
                                  final tambahdataTanaman = Penjadwalan(
                                      idTanaman: idTanaman, iduser: auth?.uid);
                                  tambahDataTanaman(item: tambahdataTanaman);
                                },
                                title: Text(namaTanaman),
                                leading: Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.2,
                                  child: CircleAvatar(
                                      backgroundImage: NetworkImage(image)),
                                )),
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
          onChange: (index) => print(index),
        ),
      ),
    );
  }

  static Future<void> tambahDataTanaman({required Penjadwalan item}) async {
    print(auth?.uid);
    print('oke');
    await Firestore.collection("penjadwalan")
        .doc()
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }
}
