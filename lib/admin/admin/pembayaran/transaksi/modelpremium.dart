// To parse this JSON data, do
//
//     final paketPremium = paketPremiumFromJson(jsonString);

import 'dart:convert';

List<paketPremium> paketPremiumFromJson(String str) => List<paketPremium>.from(
    json.decode(str).map((x) => paketPremium.fromJson(x)));

String paketPremiumToJson(List<paketPremium> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class paketPremium {
  String? idtransaksi;
  String? namaPaket;
  String? jumlahNominal;
  String? deskripsi;
  String? update;

  paketPremium({
    this.idtransaksi,
    this.namaPaket,
    this.jumlahNominal,
    this.deskripsi,
    this.update,
  });

  factory paketPremium.fromJson(Map<String, dynamic> json) => paketPremium(
        idtransaksi: json["idtransaksi"],
        namaPaket: json["namaPaket"],
        jumlahNominal: json["jumlahNominal"],
        deskripsi: json["deskripsi"],
        update: json["update"],
      );

  Map<String, dynamic> toJson() => {
        "idtransaksi": idtransaksi,
        "namaPaket": namaPaket,
        "jumlahNominal": jumlahNominal,
        "deskripsi": deskripsi,
        "update": update,
      };
}
