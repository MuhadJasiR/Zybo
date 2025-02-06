import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zybo/core/api/api_config.dart';

class AuthRemoteDataSource {
  final Dio dio = Dio();

  Future<String> verifyUser(String phoneNumber) async {
    const path = "${ApiConfig.baseUrl}${ApiConfig.verifyLogin}";

    final prefs = await SharedPreferences.getInstance();
    final response = await dio.post(path, data: {"phone_number": phoneNumber});
    log(response.toString(), name: "response");
    await prefs.setBool("user_status", response.data["user"]);
    if (response.data["user"]) {
      log("hy...");
      await prefs.setString("access_token", response.data["token"]["access"]);
    }

    return response.data["otp"];
  }

  Future<String> loginOrRegister(String phoneNumber,
      {String? firstName}) async {
    const path = "${ApiConfig.baseUrl}${ApiConfig.loginOrRegister}";
    final prefs = await SharedPreferences.getInstance();
    final response = await dio.post(path, data: {
      "phone_number": phoneNumber,
      if (firstName != null) "first_name": firstName,
    });
    if (response.data["token"] != null) {
      await prefs.setString("access_token", response.data["token"]["access"]);
    }
    log("${response.data["token"]}", name: "Register token");
    return response.data["token"]["access"];
  }
}
