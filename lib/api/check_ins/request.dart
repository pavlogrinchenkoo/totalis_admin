import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/api/request.dart';

class CheckInsRequest {
  final Request _request = Request();

  Future<CheckInModel?> create(CheckInRequestModel body) async {
    final res = await _request.post('api/admin/checkin/create', body);
    if (res == null) return null;
    return CheckInModel.fromJson(res);
  }

  Future<List<CheckInModel>?> getAll() async {
    final res = await _request.get('api/admin/checkin/get/page/0');
    if (res == null) return null;
    return (res as List).map((e) => CheckInModel.fromJson(e)).toList();
  }

  Future<CheckInModel?> get(String? id) async {
    final res = await _request.get('api/admin/checkin/get/id/$id');
    if (res == null) return null;
    return CheckInModel.fromJson(res);
  }

  Future<List<CheckInModel>?> getFromUserCategory(int id) async {
    final res =
        await _request.post('api/user/checkin/get', {'user_category_id': id});
    if (res == null) return null;
    return (res as List).map((e) => CheckInModel.fromJson(e)).toList();
  }

  Future<CheckInModel?> change(CheckInModel? item) async {
    final res = await _request.post('api/admin/checkin/change', item);
    if (res == null) return null;
    return CheckInModel.fromJson(res);
  }
}
