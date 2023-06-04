// To parse this JSON data, do
//
//     final penjadwalan = penjadwalanFromJson(jsonString);

import 'dart:convert';

List<akunPembayaran> penjadwalanFromJson(String str) => List<akunPembayaran>.from(json.decode(str).map((x) => akunPembayaran.fromJson(x)));

String penjadwalanToJson(List<akunPembayaran> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class akunPembayaran {
    String? idPemabayaran;
    String? namaAkun;
    String? namaBank;
    String? nomerRekening;
    String? deksripsi;
    String? imageUrl;
    String? upDate;

    akunPembayaran({
        this.idPemabayaran,
        this.namaAkun,
        this.namaBank,
        this.nomerRekening,
        this.deksripsi,
        this.imageUrl,
        this.upDate,
    });

    factory akunPembayaran.fromJson(Map<String, dynamic> json) => akunPembayaran(
        idPemabayaran: json["idPemabayaran"],
        namaAkun: json["namaAkun"],
        namaBank: json["namaBank"],
        nomerRekening: json["nomerRekening"],
        deksripsi: json["deksripsi"],
        imageUrl: json["imageURL"],
        upDate: json["upDate"],
    );

    Map<String, dynamic> toJson() => {
        "idPemabayaran": idPemabayaran,
        "namaAkun": namaAkun,
        "namaBank": namaBank,
        "nomerRekening": nomerRekening,
        "deksripsi": deksripsi,
        "imageURL": imageUrl,
        "upDate": upDate,
    };
}
