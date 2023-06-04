// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

// List<Users> usersFromJson(String str) =>
//     List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

// String usersToJson(List<Users> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  String? namaLengkap;
  String? email;
  String? password;
  String? pekerjaan;
  String? usia;
  String? uid;
  String? noTelp;
  String? status;
  String? gender;
  String? domisili;
  String? image;
  String? addtime;

  Users(
      {this.namaLengkap,
      this.pekerjaan,
      this.password,
      this.email,
      this.uid,
      this.usia,
      this.noTelp,
      this.domisili,
      this.gender,
      this.image,
      this.addtime,
      this.status});
  Map<String, dynamic> toJson() {
    return {
      "namaLengkap": namaLengkap,
      "email": email,
      "password": password,
      "pekerjaan": pekerjaan,
      "uid": uid,
      "usia": usia,
      "noTelp": noTelp,
      "status": status,
      "gender": gender,
      "domisili": domisili,
      "image": image,
      "addtime": addtime,
    };
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      namaLengkap: json['namaProduct'],
      email: json['email'],
      password: json['penanaman'],
      pekerjaan: json['pekerjaan'],
      uid: json['uid'],
      usia: json['usia'],
      noTelp: json['noTelp'],
      status: json['status'],
      gender: json['gender'],
      domisili: json['domisili'],
      image: json['image'],
      addtime: json['addtime'],
    );
  }
}
