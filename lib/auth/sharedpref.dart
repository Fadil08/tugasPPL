import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(jsonDecode(key));
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
      print("berhasil");
    } catch (e) {
      print(e);
    }
  }
}
