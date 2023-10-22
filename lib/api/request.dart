import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Request {
  Request() {
    getTokenId();
  }

  final dio = Dio();

  static const String baseUrl = 'http://34.139.170.74/';
  static const String tokenKey = 'tokenKey';
  String? token;

  Future<dynamic> get(String url) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': token ?? await getTokenId(),
    };
    dio.options.headers = headers;

    try {
      Response response = await dio.get(baseUrl + url);

      if (response.data.runtimeType == List<dynamic>) {
        return response.data.map((e) => e).toList();
      } else {
        return jsonDecode(response.data);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        final hasToken = await getTokenFromFirebase();
        if (hasToken != null && hasToken.isNotEmpty) {
          Response response = await dio.get(baseUrl + url);
          return response.data;
        } else {
          return null;
        }
      }
      return null;
    }
  }

  Future<Map<String, dynamic>?> post(String url, body) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': token ?? await getTokenId(),
    };
    dio.options.headers = headers;

    try {
      Response response = await dio.post(baseUrl + url, data: body.toJson());
      // print(response.statusCode);
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        final hasToken = await getTokenFromFirebase();
        if (hasToken != null && hasToken.isNotEmpty) {
          Response response = await dio.get(baseUrl + url);
          return response.data;
        } else {
          return null;
        }
      }
    }
  }

  Future<String> getTokenId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(tokenKey);
    return token ?? '';
  }

  Future<void> setTokenId(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    this.token = token;
    await prefs.setString(tokenKey, token ?? '');
  }

  Future<String?> getTokenFromFirebase() async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    setTokenId(idToken);
    return idToken;
  }
}
