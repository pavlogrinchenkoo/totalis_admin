import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';

class UserCategoriesRequest {
  final Request _request = Request();

  Future<UserCategoryModel?> create(UserCategoryRequestModel body) async {
    final res = await _request.post('api/admin/user_category/create', body);
    if (res == null) return null;
    return UserCategoryModel.fromJson(res);
  }

  Future<UserCategoryModel?> get(String id) async {
    final res = await _request.get('api/admin/user_category/get/id/$id');
    if (res == null) return null;
    return UserCategoryModel.fromJson(res);
  }

  Future<List<UserCategoryModel>?> getAll() async {
    final res = await _request.get('api/admin/user_category/get/page/0');
    if (res == null) return null;
    return (res as List).map((e) => UserCategoryModel.fromJson(e)).toList();
  }

  Future<UserCategoryModel?> change(UserCategoryModel? item) async {
    final res = await _request.post('api/admin/user_category/change', item);
    if (res == null) return null;
    return UserCategoryModel.fromJson(res);
  }
}
