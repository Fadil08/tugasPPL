import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class listdataRiwayatTransaksi extends StatefulWidget {
  const listdataRiwayatTransaksi({super.key});

  @override
  State<listdataRiwayatTransaksi> createState() =>
      _listdataRiwayatTransaksiState();
}

class _listdataRiwayatTransaksiState extends State<listdataRiwayatTransaksi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Data Transaksi'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('terdadi kesalahan${snapshot.hasError}'));
            }
            if (snapshot.hasData) {
              
            }
            return Container();
          },
        ));
  }
}
