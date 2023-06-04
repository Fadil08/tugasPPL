import 'package:flutter/material.dart';
import 'package:mychat/homepage/pembayaran/databasePembayaran.dart';
import 'package:mychat/homepage/pembayaran/qr.dart';
import 'package:mychat/util.dart';
import 'package:mychat/utils/theme.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyHomePembayaran extends StatefulWidget {
  // String? namapaket, nominal, deskripsi;
  const MyHomePembayaran(
      {
      // this.namapaket, this.nominal, this.deskripsi,
      super.key});

  @override
  State<MyHomePembayaran> createState() => _MyHomePembayaranState();
}

class _MyHomePembayaranState extends State<MyHomePembayaran> {
  Stream<QuerySnapshot<Object?>> onAkunBank() {
    // setState(() {});
    return databaseakunPembayaran.getData('akunPembayaran');
  }

  int _jumlah = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            width: size.width * 1,
            height: size.height * 0.1,
            child: Text(
              'Pembayaran Go Premium apps',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
                color: ColorPelatte.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
          // Padding(padding: 10)
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(top: 5, left: 20),
            width: size.width * 1,
            height: size.height * 0.05,
            child: Text(
              'Pilih Metode Transaksi : ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              // textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
                color: ColorPelatte.bg,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
          // Expanded(
          //   child: StreamBuilder<QuerySnapshot>(
          //     stream: onAkunBank(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         return const Text('null');
          //       } else if (snapshot.hasData || snapshot.data != null) {
          //         return ListView.separated(
          //             itemBuilder: (context, index) {
          //               DocumentSnapshot dsData = snapshot.data!.docs[index];
          //               String namaBank = dsData['namaBank'];
          //               String nomerRekening = dsData['nomerRekening'];
          //               // String image = dsData['imageURL'];
          //               String namaAkun = dsData['namaAkun'];

          //               _jumlah = snapshot.data!.docs.length;
          //               return Padding(
          //                 padding: EdgeInsets.all(3),
          //                 child: ListTile(
          //                   onTap: () {
          //                     Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: ((context) => deskripsiAkun(
          //                                 namaAkun,
          //                                 nomerRekening,
          //                                 namaAkun,
          //                                 namaBank,
          //                                 namaAkun))));
          //                   },
          //                   title: Text(namaBank),
          //                   subtitle: Text(namaAkun),
          //                   // leading: Container(
          //                   //   width: size.width * 0.2,
          //                   //   height: size.height * 0.2,
          //                   //   child: CircleAvatar(
          //                   //       backgroundImage: NetworkImage(image)),
          //                   // )
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
          // Container(
          //   padding: EdgeInsets.only(left: 20),
          //   width: size.width * 0.5,
          //   height: size.height * 0.05,
          //   // color: ColorPelatte.secondary,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: ColorPelatte.underlineTextField),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Text(
          //         'Get To Premium ',
          //         style: TextStyle(color: ColorPelatte.fontcolor),
          //       ),
          //       Icon(
          //         Icons.workspace_premium,
          //         color: Colors.amber.shade600,
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: size.height * 0.2,
          // )
        ],
      ),
    );
  }
}
