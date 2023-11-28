import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/api/variable/dto.dart';

class PromptRequest {
  final Request _request = Request();

  Future<String?> promptCategory(
      String? prompt, int? userId, int? userCategoryId, int? messageId) async {
    final res = await _request.post('api/admin/prompt/category', {
      "prompt": prompt,
      "user_category_id": userCategoryId,
      "message_id": messageId,
      "user_id": userId
    });
    if (res == null) return null;
    return res;
  }

  Future<String?> promptCheckinProposalCategory(
      String? prompt, int? userId, int? userCategoryId) async {
    final res = await _request.post('api/admin/prompt/category_welcome', {
      "prompt": prompt,
      "user_category_id": userCategoryId,
      "user_id": userId
    });
    if (res == null) return null;
    return res;
  }

  Future<String?> promptCheckinCategory(
      String? prompt, int? userId, int? checkinId, int? messageId) async {
    final res = await _request.post('api/admin/prompt/checkin', {
      "prompt": prompt,
      "checkin_id": checkinId,
      "message_id": messageId,
      "user_id": userId
    });
    if (res == null) return null;
    return res;
  }

  Future<String?> promptLLM(String text) async {
    final res = await _request.post('api/admin/prompt/llm', {"text": text});
    if (res == null) return null;
    return res['text'];
  }
}
