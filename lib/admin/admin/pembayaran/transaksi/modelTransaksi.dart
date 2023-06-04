// To parse this JSON data, do
//
//     final penjadwalan = penjadwalanFromJson(jsonString);

import 'dart:convert';

List<Penjadwalan> penjadwalanFromJson(String str) => List<Penjadwalan>.from(
    json.decode(str).map((x) => Penjadwalan.fromJson(x)));

String penjadwalanToJson(List<Penjadwalan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Penjadwalan {
  String? idtransaksi;
  String? namaUser;
  String? jumlahNominal;
  String? namaBank;
  String? nomerRekening;
  String? deskripsi;
  String? imageUrl;
  String? update;
  String? statusTransaksi;

  Penjadwalan({
    this.idtransaksi,
    this.namaUser,
    this.jumlahNominal,
    this.namaBank,
    this.nomerRekening,
    this.deskripsi,
    this.imageUrl,
    this.update,
    this.statusTransaksi,
  });

  factory Penjadwalan.fromJson(Map<String, dynamic> json) => Penjadwalan(
        idtransaksi: json["idtransaksi"],
        namaUser: json["namaUser"],
        jumlahNominal: json["jumlahNominal"],
        namaBank: json["namaBank"],
        nomerRekening: json["nomerRekening"],
        deskripsi: json["deskripsi"],
        imageUrl: json["imageURL"],
        update: json["update"],
        statusTransaksi: json["statusTransaksi"],
      );

  Map<String, dynamic> toJson() => {
        "idtransaksi": idtransaksi,
        "namaUser": namaUser,
        "jumlahNominal": jumlahNominal,
        "namaBank": namaBank,
        "nomerRekening": nomerRekening,
        "deskripsi": deskripsi,
        "imageURL": imageUrl,
        "update": update,
        "statusTransaksi": statusTransaksi,
      };
}
