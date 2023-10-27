import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:build_context_provider/build_context_provider.dart';

// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalis_admin/main.dart';
import 'package:totalis_admin/routers/routes.dart';

class Request {
  Request() {
    getTokenId();
  }

  // final dio = Dio();

  static const String baseUrl = 'https://web.totalis.app/';
  static const String tokenKey = 'tokenKey';
  String? token;
  int attempt = 0;

  Future<dynamic> get(String url) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': token ?? await getTokenId(),
      'Content-Type': 'application/json',
    };
    // dio.options.headers = headers;

    // try {
    http.Response response =
        await http.get(Uri.parse(baseUrl + url), headers: headers);
    final res = jsonDecode(response.body);
    alice.onHttpResponse(response);

    if (response.statusCode == 401) {
      logout();
      return null;
    }
    if (res.runtimeType == List<dynamic>) {
      return res.map((e) => e).toList();
    } else {
      return res;
    }

    // } on Error catch (e) {
    //
    // }
  }

  Future<Map<String, dynamic>?> post(String url, body) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token ?? await getTokenId(),
    };
    // dio.options.headers = headers;

    http.Response response = await http.post(Uri.parse(baseUrl + url),
        body: jsonEncode(body), headers: headers);
    print(jsonEncode(body));
    final res = jsonDecode(response.body);
    alice.onHttpResponse(response);
    if (response.statusCode == 401) {
      logout();
      return null;
    } else {
      return res;
    }
    // return null;
  }

  Future<String> getTokenId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(tokenKey);
    if (token == null) {
      getTokenFromFirebase();
    }
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

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    GoToProfilePage.call();
  }
}

class GoToProfilePage {
  static void call() {
    BuildContextProvider().call(
        (context) => context.router.replaceAll([LoginRoute(reLogin: true)]));
  }
}
