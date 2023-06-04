// To parse this JSON data, do
//
//     final tanaman = tanamanFromJson(jsonString);

import 'dart:convert';

List<Tanaman> tanamanFromJson(String str) =>
    List<Tanaman>.from(json.decode(str).map((x) => Tanaman.fromJson(x)));

String tanamanToJson(List<Tanaman> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tanaman {
  String? namaTanaman;
  String? idTanaman;
  String? deksripsi;
  String? deskripsiPerawatan1;
  String? deskripsiPerawatan2;
  String? deskripsiPerawatan3;
  String? imageUrl;
  String? roleTanaman;
  String? upDate;
  int? wktPengolahanTanah;
  int? wktTanam;
  int? rangePenanaman;
  int? wktperawatan1;
  int? wktpemupukan;
  int? wktPenyiraman;
  int? wktPerawatan2;
  int? wkkInseksida;
  int? wktperawatan3;
  int? wktPanen;
  String? deskripsiCarapenanaman;

  Tanaman({
    this.namaTanaman,
    this.idTanaman,
    this.deksripsi,
    this.imageUrl,
    this.roleTanaman,
    this.upDate,
    this.wktTanam,
    this.deskripsiCarapenanaman,
    this.wktperawatan1,
    this.rangePenanaman,
    this.wktperawatan3,
    this.wktPanen,
    this.wkkInseksida,
    this.wktPengolahanTanah,
    this.wktPenyiraman,
    this.wktPerawatan2,
    this.wktpemupukan,
    this.deskripsiPerawatan1,
    this.deskripsiPerawatan2,
    this.deskripsiPerawatan3,
  });

  factory Tanaman.fromJson(Map<String, dynamic> json) => Tanaman(
        namaTanaman: json["namaTanaman"],
        idTanaman: json["idTanaman"],
        deksripsi: json["deksripsi"],
        imageUrl: json["imageURL"],
        wktTanam: json["wktTanam"],
        roleTanaman: json["roleTanaman"],
        deskripsiCarapenanaman: json["deskripsiCarapenanaman"],
        wktperawatan1: json["wktperawatan1"],
        wktPerawatan2: json["wktPerawatan2"],
        wktperawatan3: json["wktperawatan3"],
        rangePenanaman: json["rangePenanaman"],
        wkkInseksida: json["wkkInseksida"],
        wktPanen: json["wktPanen"],
        wktPengolahanTanah: json["wktPengolahanTanah"],
        wktPenyiraman: json["wktPenyiraman"],
        wktpemupukan: json["wktpemupukan"],
        deskripsiPerawatan1: json["deskripsiPerawatan1"],
        deskripsiPerawatan2: json["deskripsiPerawatan2"],
        deskripsiPerawatan3: json["deskripsiPerawatan3"],
        upDate: json["upDate"],
      );

  Map<String, dynamic> toJson() => {
        "namaTanaman": namaTanaman,
        "idTanaman": idTanaman,
        "deksripsi": deksripsi,
        "imageURL": imageUrl,
        "roleTanaman": roleTanaman,
        "upDate": upDate,
        "deskripsiCarapenanaman": deskripsiCarapenanaman,
        "wktperawatan1": wktperawatan1,
        "wktTanam": wktTanam,
        "wktPerawatan2": wktPerawatan2,
        "wktPengolahanTanah": wktPengolahanTanah,
        // "wktPengolahanTanah": wktPengolahanTanah,
        "wktpemupukan": wktpemupukan,
        "wkkInseksida": wkkInseksida,
        "wktperawatan3": wktperawatan3,
        "wktPanen": wktPanen,
        "deskripsiPerawatan1": deskripsiPerawatan1,
        "deskripsiPerawatan2": deskripsiPerawatan2,
        "deskripsiPerawatan3": deskripsiPerawatan3,
        "upDate": upDate,
      };
}
