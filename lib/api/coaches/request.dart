import 'package:totalis_admin/api/coaches/dto.dart';
import 'package:totalis_admin/api/request.dart';

class CoachesRequest {
  final Request _request = Request();

  Future<CoachesModel?> create(CoachesRequestModel body) async {
    final res = await _request.post('api/admin/coach/create', body);
    if (res == null) return null;
    return CoachesModel.fromJson(res);
  }

  Future<List<CoachesModel>?> getAll() async {
    final res = await _request.get('api/admin/coach/get/page/0');
    if (res == null) return null;
    return (res as List).map((e) => CoachesModel.fromJson(e)).toList();
  }

  Future<CoachesModel?> change(CoachesModel? item) async {
    final res = await _request.post('api/admin/coach/change', item);
    if (res == null) return null;
    return CoachesModel.fromJson(res);
  }
}
