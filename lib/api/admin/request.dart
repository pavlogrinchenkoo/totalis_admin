import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalis_admin/api/admin/dto.dart';
import 'package:totalis_admin/api/request.dart';

class AdminRequest {
  final Request _request = Request();
  static const userKey = 'user';

  Future<AdminModel?> create(AdminRequestModel body) async {
    final res = await _request.post('api/admin/admins/create', body);
    if (res == null) return null;
    return AdminModel.fromJson(res);
  }

  Future<AdminModel?> change(AdminModel? item) async {
    final res = await _request.post('api/admin/admins/change', item);
    if (res == null) return null;
    return AdminModel.fromJson(res);
  }

  Future<void> setAdminToLocal(AdminModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(userKey, jsonEncode(user.toJson()));
  }

  Future<AdminModel?> getAdminToLocal(AdminModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final localAdmin = prefs.getString(userKey);
    if (localAdmin == '') return null;
    return AdminModel.fromJson(jsonDecode(localAdmin ?? ''));
  }

  Future<List<AdminModel>?> getAdmins() async {
    final res = await _request.get('api/admin/admins/get/page/0');
    if (res == null) return null;
    return (res as List).map((e) => AdminModel.fromJson(e)).toList();
  }


}
