import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/api/request.dart';

class CategoriesRequest {
  final Request _request = Request();

  Future<CategoryModel?> create(CategoryModelRequest body) async {
    final res = await _request.post('api/admin/category/create', body);
    if (res == null) return null;
    return CategoryModel.fromJson(res);
  }

  Future<List<CategoryModel>?> getAll() async {
    final res = await _request.get('api/admin/category/get/page/0');
    if (res == null) return null;
    return (res as List).map((e) => CategoryModel.fromJson(e)).toList();
  }

  Future<CategoryModel?> change(CategoryModel? item) async {
    final res = await _request.post('api/admin/category/change', item);
    if (res == null) return null;
    return CategoryModel.fromJson(res);
  }
}
