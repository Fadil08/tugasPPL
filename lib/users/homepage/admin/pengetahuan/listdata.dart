// import 'package:belajar_firebase/users/penjadwalan/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mychat/admin/pengetahuan/databasePengetahuna.dart';
import 'package:mychat/admin/pengetahuan/modelDataTananama.dart';
import 'package:mychat/admin/pengetahuan/tambah%20_data.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:mychat/utils/theme.dart';

class listPengetahuan extends StatefulWidget {
  final Pengetahuan? dataDet;
  const listPengetahuan({Key? key, this.dataDet}) : super(key: key);

  @override
  State<listPengetahuan> createState() => _detDataState();
}

class _detDataState extends State<listPengetahuan> {
  // final _searchText = TextEditingController();
  // final _namaTanaman = TextEditingController();
  // final _deskripsi = TextEditingController();
  static TextEditingController _searchText = TextEditingController();
  static TextEditingController _namaTanaman = TextEditingController();
  static TextEditingController _deskripsi = TextEditingController();

  @override
  void dispose() {
    _searchText.dispose();
    _namaTanaman.dispose();
    _deskripsi.dispose();
    super.dispose();
  }

  @override
  Stream<QuerySnapshot<Object?>> onSearch(role) {
    setState(() {});
    return databasepengetahuan.getData(role);
  }

  int _jumlah = 0;
  @override
  void initState() {
    // _searchText.addListener(onSearch);
    _namaTanaman.text = widget.dataDet?.namaPengetahuan ?? "";
    _deskripsi.text = widget.dataDet?.deksripsi ?? "";
    super.initState();
  }

  bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pengetahuan'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TambahPengetahuan()));
          },
          child: Icon(Icons.add)),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: ColorPelatte.bg,
        width: size.width * 1,
        height: size.height * 1,
        child: ContainedTabBarView(
          tabs: [
            Text('Tanaman'),
            Text('pupuk'),
            Text('Pestisida'),
            Text('Hama'),
          ],
          views: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: onSearch('Tanaman'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('null');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot dsData = snapshot.data!.docs[index];
                          String lvJudul = dsData['nama_pengetahuan'];
                          String lvdeskripsi = dsData['rolePengetahuan'];
                          String image = dsData['imageURL'];

                          _jumlah = snapshot.data!.docs.length;
                          return Padding(
                            padding: EdgeInsets.all(3),
                            child: ListTile(
                                onTap: () {
                                  // final dtBaru = Tanaman(
                                  //   namaTanaman: lvJudul,
                                  //   deskripsi: lvdeskripsi,
                                  // );
                                  // databaseTanaman.tambahDataTanaman(
                                  //     item: dtBaru);
                                },
                                title: Text(lvJudul),
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
                stream: onSearch('Pupuk'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('null');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot dsData = snapshot.data!.docs[index];
                          String lvJudul = dsData['nama_pengetahuan'];
                          String lvdeskripsi = dsData['rolePengetahuan'];
                          String image = dsData['imageURL'];

                          _jumlah = snapshot.data!.docs.length;
                          return Padding(
                            padding: EdgeInsets.all(3),
                            child: ListTile(
                                onTap: () {
                                  // final dtBaru = Tanaman(
                                  //   namaTanaman: lvJudul,
                                  //   deskripsi: lvdeskripsi,
                                  // );
                                  // databaseTanaman.tambahDataTanaman(
                                  //     item: dtBaru);
                                },
                                title: Text(lvJudul),
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
                stream: onSearch('Pestisida'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('null');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot dsData = snapshot.data!.docs[index];
                          String lvJudul = dsData['nama_pengetahuan'];
                          String lvdeskripsi = dsData['rolePengetahuan'];
                          String image = dsData['imageURL'];

                          _jumlah = snapshot.data!.docs.length;
                          return Padding(
                            padding: EdgeInsets.all(3),
                            child: ListTile(
                                onTap: () {
                                  // final dtBaru = Tanaman(
                                  //   namaTanaman: lvJudul,
                                  //   deskripsi: lvdeskripsi,
                                  // );
                                  // databaseTanaman.tambahDataTanaman(
                                  //     item: dtBaru);
                                },
                                title: Text(lvJudul),
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
                stream: onSearch('Hama'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('null');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot dsData = snapshot.data!.docs[index];
                          String lvJudul = dsData['nama_pengetahuan'];
                          String lvdeskripsi = dsData['rolePengetahuan'];
                          String image = dsData['imageURL'];
                          _jumlah = snapshot.data!.docs.length;
                          return Padding(
                            padding: EdgeInsets.all(3),
                            child: ListTile(
                                onTap: () {
                                  // final dtBaru = Tanaman(
                                  //   namaTanaman: lvJudul,
                                  //   deskripsi: lvdeskripsi,
                                  // );
                                  // databaseTanaman.tambahDataTanaman(
                                  //     item: dtBaru);
                                },
                                title: Text(lvJudul),
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
}
