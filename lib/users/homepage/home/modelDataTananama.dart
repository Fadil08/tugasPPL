// To parse this JSON data, do
//
//     final Pengetahuan = PengetahuanFromJson(jsonString);

import 'dart:convert';

List<PengetahuanHome> PengetahuanHomeFromJson(String str) =>
    List<PengetahuanHome>.from(
        json.decode(str).map((x) => PengetahuanHome.fromJson(x)));

String PengetahuanHomeToJson(List<PengetahuanHome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PengetahuanHome {
  String? namaPengetahuan;
  String? idPengetahuan;
  String? deksripsi;
  String? imageUrl;
  String? rolePengetahuan;
  String? infoPemakaian;
  String? dateUP;

  PengetahuanHome({
    this.namaPengetahuan,
    this.idPengetahuan,
    this.deksripsi,
    this.imageUrl,
    this.rolePengetahuan,
    this.infoPemakaian,
    this.dateUP,
  });

  factory PengetahuanHome.fromJson(Map<String, dynamic> json) =>
      PengetahuanHome(
        namaPengetahuan: json["nama_pengetahuan"],
        idPengetahuan: json["id_pengetahuan"],
        deksripsi: json["deksripsi"],
        imageUrl: json["imageURL"],
        rolePengetahuan: json["rolePengetahuan"],
        infoPemakaian: json["infoPemakaian"],
        dateUP: json["dateUP"],
      );

  Map<String, dynamic> toJson() => {
        "nama_pengetahuan": namaPengetahuan,
        "id_pengetahuan": idPengetahuan,
        "deksripsi": deksripsi,
        "imageURL": imageUrl,
        "rolePengetahuan": rolePengetahuan,
        "infoPemakaian": infoPemakaian,
        "dateUP": dateUP,
      };
}
