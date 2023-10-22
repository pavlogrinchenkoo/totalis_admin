import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/api/recommendation/dto.dart';
import 'package:totalis_admin/api/request.dart';

class RecommendationRequest {
  final Request _request = Request();

  Future<RecommendationModel?> create(RecommendationRequestModel body) async {
    final res = await _request.post('api/admin/recommendation/create', body);
    if (res == null) return null;
    return RecommendationModel.fromJson(res);
  }

  Future<List<RecommendationModel>?> getAll() async {
    final res = await _request.get('api/admin/recommendation/get/page/0');
    if (res == null) return null;
    return (res as List).map((e) => RecommendationModel.fromJson(e)).toList();
  }

  Future<RecommendationModel?> change(RecommendationModel? item) async {
    final res = await _request.post('api/admin/recommendation/change', item);
    if (res == null) return null;
    return RecommendationModel.fromJson(res);
  }
}
