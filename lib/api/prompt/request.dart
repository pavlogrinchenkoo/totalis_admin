import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/api/variable/dto.dart';

class PromptRequest {
  final Request _request = Request();

  Future<String?> promptCategory(
      String? prompt, String? message, int? userId, int? categoryId) async {
    final res = await _request.post('api/admin/prompt/category', {
      "prompt": prompt,
      "message": message,
      "user_id": userId,
      "category_id": categoryId
    });
    if (res == null) return null;
    return res;
  }

  Future<String?> promptCheckinProposalCategory(
      String? prompt, String? message, int? userId, int? categoryId) async {
    final res = await _request.post('api/admin/prompt/category_welcome', {
      "prompt": prompt,
      "message": message,
      "user_id": userId,
      "category_id": categoryId
    });
    if (res == null) return null;
    return res;
  }

  Future<String?> promptCheckinCategory(
      String? prompt, String? message, int? userId, int? categoryId) async {
    final res = await _request.post('api/admin/prompt/checkin', {
      "prompt": prompt,
      "message": message,
      "user_id": userId,
      "category_id": categoryId
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
