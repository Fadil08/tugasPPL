// To parse this JSON data, do
//
//     final penjadwalan = penjadwalanFromJson(jsonString);

import 'dart:convert';

List<pembayaran> penjadwalanFromJson(String str) => List<pembayaran>.from(json.decode(str).map((x) => pembayaran.fromJson(x)));

String penjadwalanToJson(List<pembayaran> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class pembayaran {
    String? idPemabayaran;
    String? namaAkun;
    String? namaBank;
    String? nomerRekening;
    String? deksripsi;
    String? imageUrl;
    String? upDate;

    pembayaran({
        this.idPemabayaran,
        this.namaAkun,
        this.namaBank,
        this.nomerRekening,
        this.deksripsi,
        this.imageUrl,
        this.upDate,
    });

    factory pembayaran.fromJson(Map<String, dynamic> json) => pembayaran(
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
