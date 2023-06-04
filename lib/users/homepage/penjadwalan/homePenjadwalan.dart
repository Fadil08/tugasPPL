import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../admin/admin/pembayaran/transaksi/modelTransaksi.dart';
import '../../../utils/theme.dart';
import '../home/homepage.dart';
import 'listdataTanaman.dart';

class HomePagePenjadwalan extends StatefulWidget {
  const HomePagePenjadwalan({super.key});

  @override
  State<HomePagePenjadwalan> createState() => _HomePagePenjadwalanState();
}

String? acceptstatus;
List pilihMenu = ["true", "false"];
List pendingOrderLoaderList1 = [];

class _HomePagePenjadwalanState extends State<HomePagePenjadwalan> {
  final _searchText = TextEditingController();
  final startJadwalControler = TextEditingController();
  late DocumentReference _referenceTanaman;
  late Stream<DocumentSnapshot> _futureDataTanaman;
  String? olahTanah,
      Penanaman,
      wkPerawatan1,
      pemupukan,
      penyiraman,
      perawatan2,
      // inseksida,
      perawatan3,
      panen;
  var inseksida;

  Stream<QuerySnapshot<Object?>> onSearch(role) {
    setState(() {});
    return databasePenjadwalan.getPenjadwalan(role);
  }

  Stream<QuerySnapshot<Object?>> onTanaman(role) {
    // setState(() {});
    return databasePenjadwalan.getTanamanTerdata(role);
  }

  // Stream<QuerySnapshot<Object?>> onTanaman(role) {
  //   setState(() {});
  //   return databasePenjadwalan.getPenjadwalan(role);
  // }
  // datetime =
  // String? olahTanah,
  int _jumlah = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjadwalan'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => listDataTanamanTerdata()));
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
              style: TextStyle(color: ColorPelatte.underlineTextField),
            ),
            Text('Pertanian',
                style: TextStyle(color: ColorPelatte.underlineTextField)),
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
                          // String lvdeskripsi = dsData['roleTanaman'];
                          String image = dsData['imageURL'];
                          String id = dsData['idTanaman'];
                          String statusjadwal = dsData['statusJadwal'];
                          var startJadwal = dsData["startjadwal"];
                          _jumlah = snapshot.data!.docs.length;
                          var iddata = dsData.id;
                          List<penjadwalan> pendingOrderLoaderList1 = [];

                          return StreamBuilder(
                              stream: onTanaman('Hias'),
                              builder: (context, snapshotTanaman) {
                                DocumentSnapshot dataTanaman =
                                    snapshot.data!.docs[index];
                                String namatanaman = dataTanaman["namaTanaman"];
                                // String imageTanaman = dataTanaman["imageURL"];
                                // var namaTanaman;
                                var idTanaman = dataTanaman["idTanaman"];
                                var deksripsi = dataTanaman["deskripsi"];
                                var deskripsiPerawatan1 =
                                    dataTanaman["deskripsiPerawatan1"];

                                var deskripsiPerawatan2 =
                                    dataTanaman["deskripsiPerawatan2"];

                                var deskripsiPerawatan3 =
                                    dataTanaman["deskripsiPerawatan3"];

                                var imageUrl = dataTanaman["imageUrl"];

                                var roleTanaman = dataTanaman["roleTanaman"];
                                // String upDate= dataTanaman[""];
                                // int? rangePenanaman= dataTanaman[];
                                //
                                //penjadwalan
                                //
                                var perawatan1 =
                                    int.parse(dataTanaman["perawatan1"]);

                                var wktPengolahanTanah = int.parse(
                                    dataTanaman["wktPengolahanTanah"]);
                                var wktpemupukan =
                                    int.parse(dataTanaman["wktpemupukan"]);
                                // var wktPemupukan = int.parse(wktpemupukan);
                                var wktPenyiraman =
                                    int.parse(dataTanaman["wktPenyiraman"]);
                                var wktPerawatan2 =
                                    int.parse(dataTanaman["wktPerawatan2"]);
                                var wktPerawatan1 =
                                    int.parse(dataTanaman["wktperawatan1"]);
                                var wktperawatan3 =
                                    int.parse(dataTanaman["wktperawatan3"]);
                                var wktPanen =
                                    int.parse(dataTanaman["wktPanen"]);
                                var wkkInseksida =
                                    int.parse(dataTanaman["wkkInseksida"]);
                                var wkTanam =
                                    int.parse(dataTanaman["wktTanam"]);

                                var deskripsiCarapenanaman =
                                    dataTanaman["deskripsiCarapenanaman"];
                                startJadwalControler.text;
                                // snapshot.data!.docs[index].id;

                                if (snapshotTanaman.hasError) {
                                  return Center(
                                    child: Text(
                                        "Terjadi Kesalahan ${snapshotTanaman}"),
                                  );
                                }
                                if (snapshotTanaman.hasData ||
                                    snapshotTanaman.data != null) {
                                  return Padding(
                                    padding: EdgeInsets.all(3),
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      height: size.height * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: statusjadwal == 'true'
                                              ? Colors.green
                                              : Colors.red),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(imageUrl)),
                                          Text(namatanaman),
                                          DropdownButton(
                                            dropdownColor: Colors.green,
                                            iconEnabledColor: Colors.white,
                                            value: acceptstatus,
                                            items: pilihMenu.map((value) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                value: value,
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                acceptstatus = value as String?;
                                              });
                                              if (acceptstatus == 'true') {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return SimpleDialog(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.0,
                                                                  right: 10.0),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Text(
                                                                  "Start Jadwal",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20.0),
                                                                ),
                                                              ),
                                                              IconButton(
                                                                icon: Icon(Icons
                                                                    .close),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            "Start Jadwal",
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.0,
                                                                  right: 10.0),
                                                          child: TextField(
                                                            controller:
                                                                startJadwalControler,
                                                            style: new TextStyle(
                                                                fontSize: 14.0,
                                                                height: 1.0,
                                                                color: Colors
                                                                    .black),
                                                            decoration:
                                                                new InputDecoration(
                                                              icon: IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .date_range_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                onPressed: () {
                                                                  showDatePicker(
                                                                          context:
                                                                              context,
                                                                          initialDate: DateTime
                                                                              .now(),
                                                                          firstDate: DateTime(
                                                                              2000),
                                                                          lastDate: DateTime(
                                                                              2030),
                                                                          initialEntryMode: DatePickerEntryMode
                                                                              .input)
                                                                      .then(
                                                                          (value) {
                                                                    if (value !=
                                                                        null) {
                                                                      setState(
                                                                          () {
                                                                        int setOlahTanah =
                                                                            wktPengolahanTanah.toInt();
                                                                        int setPenanaman =
                                                                            setOlahTanah.toInt() +
                                                                                wkTanam.toInt();
                                                                        int setperawatan1 =
                                                                            setPenanaman +
                                                                                wktPerawatan1;
                                                                        int setpupuk =
                                                                            setperawatan1 +
                                                                                wktpemupukan;
                                                                        int setpenyiraman =
                                                                            setpupuk +
                                                                                wktPenyiraman;
                                                                        int setperawatan2 =
                                                                            setpenyiraman +
                                                                                wktPerawatan2;
                                                                        int setInseksida =
                                                                            setperawatan2.toInt() +
                                                                                wkkInseksida.toInt();
                                                                        int setperawatan3 =
                                                                            setInseksida.toInt() +
                                                                                wkkInseksida.toInt();
                                                                        int setpanen =
                                                                            setperawatan3 +
                                                                                wktPanen;
                                                                        olahTanah = value
                                                                            .add(Duration(days: wktPengolahanTanah))
                                                                            .toString();
                                                                        Penanaman = value
                                                                            .add(Duration(days: setPenanaman))
                                                                            .toString();
                                                                        wkPerawatan1 = value
                                                                            .add(Duration(days: setperawatan1.toInt()))
                                                                            .toString();
                                                                        pemupukan = value
                                                                            .add(Duration(days: wktpemupukan.toInt()))
                                                                            .toString();
                                                                        penyiraman = value
                                                                            .add(Duration(days: setpupuk.toInt()))
                                                                            .toString();
                                                                        perawatan2 = value
                                                                            .add(Duration(days: setperawatan2))
                                                                            .toString();
                                                                        inseksida = value
                                                                            .add(Duration(days: setInseksida.toInt()))
                                                                            .toString();

                                                                        perawatan3 = value
                                                                            .add(Duration(days: setperawatan3.toInt()))
                                                                            .toString();
                                                                        panen = value
                                                                            .add(Duration(days: wktPanen))
                                                                            .toString();

                                                                        startJadwalControler.text =
                                                                            value.toString();
                                                                      });
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                              hintText:
                                                                  "Start Jadwal",
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                              .circular(
                                                                          3.0)),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          14.0,
                                                                      horizontal:
                                                                          15.0),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  10.0,
                                                                  10.0,
                                                                  10.0,
                                                                  0),
                                                          child: MaterialButton(
                                                            color: Colors.blue,
                                                            child: Text(
                                                              "SIMPAN",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              final userId =
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser;
                                                              final itemdata =
                                                                  Penjadwalan(
                                                                iduser:
                                                                    userId?.uid,
                                                                deksripsi:
                                                                    deksripsi,
                                                                idTanaman:
                                                                    idTanaman,
                                                                deskripsiperawatan1:
                                                                    deskripsiPerawatan1,
                                                                deskripsiPerawatan2:
                                                                    deskripsiPerawatan2,
                                                                deskripsiPerawatan3:
                                                                    deskripsiPerawatan3,
                                                                deskripsitambahan:
                                                                    deskripsiCarapenanaman,
                                                                imageUrl:
                                                                    imageUrl,
                                                                startjadwal:
                                                                    startJadwalControler
                                                                        .text
                                                                        .trim(),
                                                                jadwalpanen:
                                                                    panen,
                                                                tglOlahTanah:
                                                                    olahTanah,
                                                                tglPenanaman:
                                                                    Penanaman,
                                                                tglPemupukan:
                                                                    pemupukan,
                                                                tglPenyiriman:
                                                                    penyiraman,
                                                                tglperawatan1:
                                                                    wkPerawatan1,
                                                                tglperawatan2:
                                                                    perawatan2,
                                                                tglperawatan3:
                                                                    perawatan3,
                                                                idpenjadwalan:
                                                                    iddata,
                                                              );
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'penjadwalan')
                                                                  .doc(iddata)
                                                                  .update(itemdata
                                                                      .toJson())
                                                                  .whenComplete(
                                                                      () => print(
                                                                          'databerhasil di udpdate'))
                                                                  .catchError(
                                                                      (e) =>
                                                                          print(
                                                                              2));
                                                              // tambahData(item: )
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                return;
                                              }
                                            },
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                DescriptionPenjadwalan(
                                                                    name: dsData[
                                                                        'namaTanaman'],
                                                                    description:
                                                                        dsData[
                                                                            'deskripsi'],
                                                                    imageURL:
                                                                        dsData[
                                                                            'imageURL']))));
                                                  },
                                                  icon: Icon(
                                                      Icons.preview_outlined)),
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                DescriptionPenjadwalan(
                                                                    name: dsData[
                                                                        'namaTanaman'],
                                                                    description:
                                                                        dsData[
                                                                            'deskripsi'],
                                                                    imageURL:
                                                                        dsData[
                                                                            'imageURL']))));
                                                  },
                                                  icon: Icon(
                                                      Icons.edit_document)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return CircularProgressIndicator();
                              });
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
                stream: onSearch('pertanian'),
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
                                onTap: () {},
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

  CollectionReference data =
      FirebaseFirestore.instance.collection('penjadwalan');
  void tambahData({required Penjadwalan item}) async {
    try {
      DocumentReference docRef = data.doc();
      await docRef
          .set(item.toJson())
          .whenComplete(() => print("data berhasil diinput"))
          .catchError((e) => print(e));
      // notif().snackbarSucses(context, 'sukses', 'data berhasil di inputkan');
      // snackbarSucses();}
    } catch (e) {
      // notif().erorsnackbar(e);
    }
  }
}
