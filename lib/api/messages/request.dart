import 'package:totalis_admin/api/messages/dto.dart';
import 'package:totalis_admin/api/request.dart';

class MessagesRequest {
  final Request _request = Request();

  Future<MessageModel?> create(MessageRequestModel body) async {
    final res = await _request.post('api/admin/message/create', body);
    if (res == null) return null;
    return MessageModel.fromJson(res);
  }

  Future<List<MessageModel>?> getAll() async {
    final res = await _request.get('api/admin/message/get/page/0');
    if (res == null) return null;
    return (res as List).map((e) => MessageModel.fromJson(e)).toList();
  }

  Future<MessageModel?> change(MessageModel? item) async {
    final res = await _request.post('api/admin/message/change', item);
    if (res == null) return null;
    return MessageModel.fromJson(res);
  }
}
