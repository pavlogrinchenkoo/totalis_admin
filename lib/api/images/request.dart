import 'package:totalis_admin/api/images/dto.dart';
import 'package:totalis_admin/api/request.dart';

class ImageRequest {
  final Request _request = Request();

  Future<ImageModel?> create(ImageRequestModel body) async {
    final res = await _request.post('api/admin/image/create', body);
    if (res == null) return null;
    return ImageModel.fromJson(res);
  }

  Future<ImageModel?> get(String? id) async {
    final res = await _request.get('api/admin/image/get/id/$id');
    if (res == null) return null;
    return ImageModel.fromJson(res);
  }

  Future<ImageModel?> change(ImageModel? item) async {
    final res = await _request.post('api/admin/image/change', item);
    if (res == null) return null;
    return ImageModel.fromJson(res);
  }

  Future<ImageModel?> remove(String? id) async {
    final res = await _request.get('api/admin/image/remove/id/$id');
    if (res == null) return null;
    return ImageModel.fromJson(res);
  }
}
