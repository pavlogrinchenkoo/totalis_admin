import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/api/variable/dto.dart';

class VariableRequest {
  final Request _request = Request();

  Future<VariableModel?> create(VariableRequestModel body) async {
    final res = await _request.post('api/admin/variable/create', body);
    if (res == null) return null;
    return VariableModel.fromJson(res);
  }

  Future<List<VariableModel>?> getAll() async {
    final res = await _request.get('api/admin/variable/get/page/0');
    if (res == null) return null;
    return (res as List).map((e) => VariableModel.fromJson(e)).toList();
  }

  Future<VariableModel?> change(VariableModel? item) async {
    final res = await _request.post('api/admin/variable/change', item);
    if (res == null) return null;
    return VariableModel.fromJson(res);
  }
}
