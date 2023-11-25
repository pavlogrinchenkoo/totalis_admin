import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/api/system/dto.dart';

class SystemRequest {
  final Request _request = Request();

  Future<SystemModel?> get() async {
    final res = await _request.get('api/admin/system/get');
    if (res == null) return null;
    return SystemModel.fromJson(res);
  }

  Future<SystemModel?> change(SystemModel? item) async {
    final res = await _request.post('api/admin/system/change', item);
    if (res == null) return null;
    return SystemModel.fromJson(res);
  }
}
