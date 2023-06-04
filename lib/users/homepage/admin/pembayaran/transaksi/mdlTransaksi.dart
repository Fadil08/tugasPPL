// To parse this JSON data, do
//
//     final transaksi = transaksiFromJson(jsonString);

import 'dart:convert';

List<Transaksi> transaksiFromJson(String str) => List<Transaksi>.from(json.decode(str).map((x) => Transaksi.fromJson(x)));

String transaksiToJson(List<Transaksi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaksi {
    String? idtransaksi;
    String? iduser;
    String? jumlahNominal;
    String? idakunBank;
    String? deskripsi;
    String? buktiPembayaran;
    String? update;
    String? statusTransaksi;

    Transaksi({
        this.idtransaksi,
        this.iduser,
        this.jumlahNominal,
        this.idakunBank,
        this.deskripsi,
        this.buktiPembayaran,
        this.update,
        this.statusTransaksi,
    });

    factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        idtransaksi: json["idtransaksi"],
        iduser: json["iduser"],
        jumlahNominal: json["jumlahNominal"],
        idakunBank: json["idakunBank"],
        deskripsi: json["deskripsi"],
        buktiPembayaran: json["BuktiPembayaran"],
        update: json["update"],
        statusTransaksi: json["statusTransaksi"],
    );

    Map<String, dynamic> toJson() => {
        "idtransaksi": idtransaksi,
        "iduser": iduser,
        "jumlahNominal": jumlahNominal,
        "idakunBank": idakunBank,
        "deskripsi": deskripsi,
        "BuktiPembayaran": buktiPembayaran,
        "update": update,
        "statusTransaksi": statusTransaksi,
    };
}
