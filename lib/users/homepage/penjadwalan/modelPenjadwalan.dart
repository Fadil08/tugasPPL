// To parse this JSON data, do
//
//     final penjadwalan = penjadwalanFromJson(jsonString);

import 'dart:convert';

List<Penjadwalan> penjadwalanFromJson(String str) => List<Penjadwalan>.from(
    json.decode(str).map((x) => Penjadwalan.fromJson(x)));

String penjadwalanToJson(List<Penjadwalan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Penjadwalan {
  String? iduser;
  String? idpenjadwalan;
  String? idTanaman;
  String? namaTanaman;
  String? deksripsi;
  String? imageUrl;
  String? startjadwal;
  String? deskripsitambahan;
  String? deskripsiperawatan1;
  String? deskripsiPerawatan2;
  String? deskripsiPerawatan3;
  String? tglPenanaman;
  String? tglPenyiriman;
  String? tglPemupukan;
  String? jenispupuk;
  String? tglperawatan1;
  String? tglperawatan2;
  String? tglperawatan3;
  String? jadwalpanen;
  String? roleTanaman;
  String? statusJadwal;
  String? tglOlahTanah;

  Penjadwalan(
      {this.iduser,
      this.idpenjadwalan,
      this.idTanaman,
      this.namaTanaman,
      this.deksripsi,
      this.imageUrl,
      this.startjadwal,
      this.deskripsitambahan,
      this.tglPenanaman,
      this.tglPenyiriman,
      this.tglPemupukan,
      this.jenispupuk,
      this.deskripsiperawatan1,
      this.deskripsiPerawatan2,
      this.deskripsiPerawatan3,
      this.tglperawatan1,
      this.jadwalpanen,
      this.roleTanaman,
      this.statusJadwal,
      this.tglOlahTanah,
      this.tglperawatan2,
      this.tglperawatan3});

  factory Penjadwalan.fromJson(Map<String, dynamic> json) => Penjadwalan(
      iduser: json["iduser"],
      idpenjadwalan: json["idpenjadwalan"],
      idTanaman: json["idTanaman"],
      namaTanaman: json["namaTanaman"],
      deksripsi: json["deksripsi"],
      imageUrl: json["imageURL"],
      startjadwal: json["startjadwal"],
      deskripsitambahan: json["deskripsitambahan"],
      tglPenanaman: json["tglPenanaman"],
      tglPenyiriman: json["tglPenyiriman"],
      tglPemupukan: json["tglPemupukan"],
      jenispupuk: json["jenispupuk"],
      deskripsiperawatan1: json["deskripsiperawatan1"],
      deskripsiPerawatan3: json["deskripsiPerawatan3"],
      deskripsiPerawatan2: json["deskripsiPerawatan2"],
      tglperawatan1: json["tglperawatan1"],
      jadwalpanen: json["jadwalpanen"],
      roleTanaman: json["roleTanaman"],
      statusJadwal: json["statusJadwal"],
      tglOlahTanah: json["tglOlahTanah"],
      tglperawatan2: json["tglPerawatan2"],
      tglperawatan3: json["tglPerawatan3"]);

  Map<String, dynamic> toJson() => {
        "iduser": iduser,
        "idpenjadwalan": idpenjadwalan,
        "idTanaman": idTanaman,
        "idTanaman": idTanaman,
        "namaTanaman": namaTanaman,
        "deksripsi": deksripsi,
        "imageURL": imageUrl,
        "startjadwal": startjadwal,
        "deskripsitambahan": deskripsitambahan,
        "tglPenanaman": tglPenanaman,
        "tglPenyiriman": tglPenyiriman,
        "tglPemupukan": tglPemupukan,
        "jenispupuk": jenispupuk,
        "deskripsiPerawatan3": deskripsiPerawatan3,
        "deskripsiperawatan1": deskripsiperawatan1,
        "deskripsiPerawatan2": deskripsiPerawatan2,
        "tglperawatan1": tglperawatan1,
        "jadwalpanen": jadwalpanen,
        "roleTanaman": roleTanaman,
        "statusJadwal": statusJadwal,
        "tglOlahTanah": tglOlahTanah,
        "tglperawatan2": tglperawatan2,
        "tglperawatan3": tglperawatan3,
      };
}
