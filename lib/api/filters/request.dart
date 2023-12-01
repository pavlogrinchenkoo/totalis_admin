import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/messages/dto.dart';
import 'package:totalis_admin/api/models_chat_gpt/dto.dart';
import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';

class FilterRequest {
  final Request _request = Request();

  Future<List<UserModel>?> userFilters(QueryModel? queryModel) async {
    final res = await _request.post('api/admin/users/get/query', queryModel);
    if (res == null) return null;
    return (res as List).map((e) => UserModel.fromJson(e)).toList();
  }

  Future<List<UserCategoryModel>?> userCategoryFilters(
      QueryModel? queryModel) async {
    final res = await _request.post(
        'api/admin/user_category/get/query', queryModel?.toJson());
    if (res == null) return null;
    return (res as List).map((e) => UserCategoryModel.fromJson(e)).toList();
  }

  Future<List<MessageModel>?> messagesFilters(QueryModel? queryModel) async {
    final res = await _request.post(
        'api/admin/message/get/query', queryModel?.toJson());
    if (res == null) return null;
    return (res as List).map((e) => MessageModel.fromJson(e)).toList();
  }

  Future<List<CheckInModel>?> checkinsFilters(QueryModel? queryModel) async {
    final res = await _request.post(
        'api/admin/checkin/get/query', queryModel?.toJson());
    if (res == null) return null;
    return (res as List).map((e) => CheckInModel.fromJson(e)).toList();
  }

  Future<List<ModelsChatGptModel>?> modelsFilters(
      QueryModel? queryModel) async {
    final res = await _request.post(
        'api/admin/model_gpt_version/get/query', queryModel?.toJson());
    if (res == null) return null;
    return (res as List).map((e) => ModelsChatGptModel.fromJson(e)).toList();
  }
}
