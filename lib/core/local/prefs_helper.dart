import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendista_e_commerce/constants.dart';

class PrefsHelper {
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setToken(String token) async {
    return await sharedPreferences.setString(kToken, token);
  }

  static String getToken() {
    return sharedPreferences.getString(kToken) ?? '';
  }

  static clearToken() {
    sharedPreferences.remove(kToken);
  }
}
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PrefsHelper {
//   static late SharedPreferences sharedPreferences;
//   static Future<void> init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//
//   static Future<bool> setToken(
//       {required String key, required String value}) async {
//     return await sharedPreferences.setString(key, value);
//   }
//
//   static String getToken({required String key}) {
//     return sharedPreferences.getString(key) ?? '';
//   }
//
//   static Future<bool> deleteToken({required String key}) async {
//     return await sharedPreferences.remove(key);
//   }
// }
