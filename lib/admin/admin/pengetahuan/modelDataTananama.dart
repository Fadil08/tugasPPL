// To parse this JSON data, do
//
//     final Pengetahuan = PengetahuanFromJson(jsonString);

import 'dart:convert';

List<Pengetahuan> PengetahuanFromJson(String str) => List<Pengetahuan>.from(json.decode(str).map((x) => Pengetahuan.fromJson(x)));

String PengetahuanToJson(List<Pengetahuan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pengetahuan {
    String? namaPengetahuan;
    String? idPengetahuan;
    String? deksripsi;
    String? imageUrl;
    String? rolePengetahuan;
    String? infoPemakaian;
    String? dateUP;

    Pengetahuan({
        this.namaPengetahuan,
        this.idPengetahuan,
        this.deksripsi,
        this.imageUrl,
        this.rolePengetahuan,
        this.infoPemakaian,
        this.dateUP,
    });

    factory Pengetahuan.fromJson(Map<String, dynamic> json) => Pengetahuan(
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
