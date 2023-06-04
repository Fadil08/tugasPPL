// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  String? namalengkap;
  String? usia;
  String? email;
  String? password;
  String? pekerjaan;
  String? domisili;
  String? idUser;
  String? gender;

  Users({
    this.namalengkap,
    this.usia,
    this.email,
    this.password,
    this.pekerjaan,
    this.domisili,
    this.idUser,
    this.gender,
  });

  Map<String, dynamic> toJson() => {
        "namalengkap": namalengkap,
        "usia": usia,
        "email": email,
        "password": password,
        "pekerjaan": pekerjaan,
        "domisili": domisili,
        "id_user": idUser,
        "gnder": gender,
      };

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        namalengkap: json["namalengkap"],
        usia: json["usia"],
        email: json["email"],
        password: json["password"],
        pekerjaan: json["pekerjaan"],
        domisili: json["domisili"],
        gender: json["gender"],
        idUser: json["id_user"],
      );
}
