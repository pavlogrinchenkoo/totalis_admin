import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/api/variable/dto.dart';

class PromptRequest {
  final Request _request = Request();

  Future<String?> promptCategory(int userId) async {
    final res = await _request.post('api/admin/prompt/category',
        {"user_category_id": 58, "message_id": 71, "user_id": userId});
    if (res == null) return null;
    return res;
  }

  Future<String?> promptCheckin(int userId) async {
    final res = await _request.post('api/admin/prompt/checkin',
        {"checkin_id": 14, "message_id": 71, "user_id": userId});
    if (res == null) return null;
    return res;
  }
}
