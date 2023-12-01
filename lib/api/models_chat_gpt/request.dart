import 'package:totalis_admin/api/models_chat_gpt/dto.dart';
import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/api/variable/dto.dart';

class ModelsChatGptRequest {
  final Request _request = Request();

  Future<ModelsChatGptModel?> create(ModelsChatGptRequestModel body) async {
    final res = await _request.post('api/admin/model_gpt_version/create', body);
    if (res == null) return null;
    return ModelsChatGptModel.fromJson(res);
  }

  Future<ModelsChatGptModel?> change(ModelsChatGptModel? item) async {
    final res = await _request.post('api/admin/model_gpt_version/change', item);
    if (res == null) return null;
    return ModelsChatGptModel.fromJson(res);
  }
}
