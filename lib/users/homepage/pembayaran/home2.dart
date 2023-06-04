import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:mychat/homepage/pembayaran/databasePembayaran.dart';
// import 'package:mychat/util.dart';
import 'package:mychat/utils/theme.dart';

import 'homePembayaran.dart';

class HomePembayaran extends StatefulWidget {
  const HomePembayaran({super.key});

  @override
  State<HomePembayaran> createState() => _HomePembayaranState();
}

class _HomePembayaranState extends State<HomePembayaran> {
  Stream<QuerySnapshot<Object?>> onAkunBank() {
    // setState(() {});
    return databaseakunPembayaran.getData('paketPremium');
  }

  int _jumlah = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: ColorPelatte.bg,
          child: Column(
            children: [
              Container(
                width: size.width * 1,
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " Go Premium Appas",
                      style: TextStyle(color: ColorPelatte.fontcolor),
                    ),
                    Icon(
                      Icons.workspace_premium,
                      color: Colors.amber.shade600,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: ColorPelatte.primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              Center(
                child: Container(
                  width: size.width * 1,
                  height: size.height * 0.4,
                  child: Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: onAkunBank(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('null');
                        } else if (snapshot.hasData || snapshot.data != null) {
                          return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                DocumentSnapshot dsData =
                                    snapshot.data!.docs[index];
                                String namaPaket = dsData['namaPaket'];
                                String jumlaNominal = dsData['jumlahNominal'];
                                // String image = dsData['imageURL'];
                                String deskripsi = dsData['deskripsi'];

                                _jumlah = snapshot.data!.docs.length;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: size.width * 0.35,
                                    height: size.height * 0.35,
                                    decoration: BoxDecoration(
                                        color: ColorPelatte.underlineTextField,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Text(namaPaket,
                                            style: TextStyle(
                                              color: ColorPelatte.fontcolor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        Divider(color: Colors.white),
                                        Container(
                                          child: Text(
                                              style: TextStyle(
                                                color: ColorPelatte.fontcolor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              'Berlnganan ${namaPaket}'),
                                        ),
                                        Divider(color: Colors.white),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Text(
                                            deskripsi.toLowerCase().toString(),
                                            style: TextStyle(
                                              color: ColorPelatte.fontcolor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Text(
                                            style: TextStyle(
                                              color: ColorPelatte.fontcolor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            '- No Limit Konsultasi'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(color: Colors.white),
                                        Text(
                                            style: TextStyle(
                                              color: ColorPelatte.fontcolor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            'Harga Rp. $jumlaNominal'),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => MyHomePembayaran(
                                                        // namapaket: namaPaket,
                                                        // deskripsi: deskripsi,
                                                        // nominal: jumlaNominal,
                                                        ),
                                                  ));
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "GetTopUp",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors
                                                          .amber.shade600),
                                                ),
                                                Icon(
                                                  Icons
                                                      .workspace_premium_outlined,
                                                  size: 20,
                                                  color: Colors.amber.shade500,
                                                )
                                              ],
                                            ))
                                      ],
                                    ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
