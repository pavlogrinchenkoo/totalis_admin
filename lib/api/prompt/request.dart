import 'package:totalis_admin/api/request.dart';

class PromptRequest {
  final Request _request = Request();

  Future<String?> promptCategory(
      String? prompt, int? userId, int? categoryId) async {
    final res = await _request.post('api/admin/prompt/category',
        {"prompt": prompt, "user_id": userId, "category_id": categoryId});
    if (res == null) return null;
    return res;
  }

  Future<String?> promptCheckinProposalCategory(
      String? prompt, int? userId, int? categoryId) async {
    final res = await _request.post('api/admin/prompt/category_welcome',
        {"prompt": prompt, "user_id": userId, "category_id": categoryId});
    if (res == null) return null;
    return res;
  }

  Future<String?> promptCheckinCategory(
      String? prompt, int? userId, int? categoryId) async {
    final res = await _request.post('api/admin/prompt/checkin',
        {"prompt": prompt, "user_id": userId, "category_id": categoryId});
    if (res == null) return null;
    return res;
  }

  Future<String?> promptWhy(String? prompt, int? userId, int? categoryId,
      String? recommendation) async {
    final res = await _request.post('api/admin/prompt/recommendation_why', {
      "prompt": prompt,
      "user_id": userId,
      "category_id": categoryId,
      "recommendation": recommendation
    });
    if (res == null) return null;
    return res;
  }

  Future<String?> promptHow(String? prompt, int? userId, int? categoryId,
      String? recommendation) async {
    final res = await _request.post('api/admin/prompt/recommendation_how', {
      "prompt": prompt,
      "user_id": userId,
      "category_id": categoryId,
      "recommendation": recommendation
    });
    if (res == null) return null;
    return res;
  }

  Future<String?> promptLLM(
    String text,
    String? message,
  ) async {
    final res = await _request.post('api/admin/prompt/llm', {
      "text": text,
      "message": message,
    });
    if (res == null) return null;
    return res['text'];
  }
}
