import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/api/user/dto.dart';

class UserRequest {
  final Request _request = Request();

  Future<UserModel?> createUser(UserRequestModel body) async {
    final res = await _request.post('api/admin/users/create', body);
    if (res == null) return null;
    return UserModel.fromJson(res);
  }

  Future<List<UserModel>?> getUsers() async {
    final res = await _request.get('api/admin/users/get/page/0');
    if (res == null) return null;
    return (res as List).map((e) => UserModel.fromJson(e)).toList();
  }

  Future<UserModel?> changeUser(UserModel? item) async {
    final res = await _request.post('api/admin/users/change', item);
    if (res == null) return null;
    return UserModel.fromJson(res);
  }
}
