import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/theme.dart';

class deskripsiAkun extends StatelessWidget {
  final String namaBank, description, logobank, namaAkun, nomerrekning;
  const deskripsiAkun(this.namaBank, this.description, this.logobank,
      this.namaAkun, this.nomerrekning,
      {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPelatte.primaryColor,
        title: const Text('Scan qrcode'),
        centerTitle: true,
      ),
      body: Container(
        color: ColorPelatte.bg,
        child: Column(
          children: [
            Center(
              child: QrImageView(
                  data: nomerrekning,
                  size: 280,
                  embeddedImageStyle:
                      QrEmbeddedImageStyle(size: Size(100, 100))),
            ),
            // Container(
            //   padding: EdgeInsets.only(top: 5, left: 20),
            //   width: size.width * 1,
            //   height: size.height * 0.08,
            //   child: Text(
            //     'nama Bank : \n ${namaBank}',
            //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            //     // textAlign: TextAlign.center,
            //   ),
            //   decoration: BoxDecoration(
            //       // color: ColorPelatte.bg,
            //       borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(10),
            //           bottomRight: Radius.circular(10))),
            // ),
            Container(
              child: Row(
                children: [
                  CircleAvatar(backgroundImage: AssetImage('assets/bayam.png')),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 20),
                    // width: size.width * 1,
                    height: size.height * 0.08,
                    child: Text(
                      'nama Bank : \n ${namaBank}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      // textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                        // color: ColorPelatte.bg,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 20),
                    // width: size.width * 1,
                    height: size.height * 0.08,
                    child: Text(
                      'Nama Akun : \n ${namaAkun}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      // textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                        // color: ColorPelatte.bg,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width * 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(description, style: TextStyle(fontSize: 15)),
              ),
            ),
            // ElevatedButton(onPressed: (){}, child:)
          ],
        ),
      ),
    );
  }
}
