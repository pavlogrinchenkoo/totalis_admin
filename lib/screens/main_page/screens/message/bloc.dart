import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/messages/dto.dart';
import 'package:totalis_admin/api/messages/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class MessageBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final MessagesRequest _messageRequest = MessagesRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  MessageBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final messages = await _messageRequest.getAll();
    setState(currentState.copyWith(loading: false, messages: messages ?? []));
  }

  changeIsCheckin(MessageModel? item, bool value) async {
    if (item == null) return;
    final newCategory = item;
    newCategory.is_checkin = value;
    final changed = await _messageRequest.change(newCategory);
    if (changed?.id == null) return;
    replaceItem(changed, newCategory);
  }

  openChange(BuildContext context, MessageModel? item) {
    final fields = [
      FieldModel(
        title: 'User-category id',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(
            text: (item?.user_category_id ?? "").toString()),
      ),
      FieldModel(
        title: 'Is checkin',
        type: FieldType.checkbox,
        required: true,
        value: item?.is_checkin,
      ),
      FieldModel(
        title: 'Checkin id',
        type: FieldType.text,
        required: true,
        controller:
            TextEditingController(text: (item?.checkin_id ?? "").toString()),
      ),
      FieldModel(
        title: 'Coach id',
        type: FieldType.text,
        required: true,
        controller:
            TextEditingController(text: (item?.coach_id ?? "").toString()),
      ),
      FieldModel(
        title: 'Text',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(text: item?.text),
      ),
      FieldModel(
        title: 'Role',
        type: FieldType.dropdown,
        required: true,
        values: RoleEnum.values,
        enumValue: item?.role,
      ),
      FieldModel(
        title: 'Token used',
        type: FieldType.text,
        required: true,
        controller:
            TextEditingController(text: (item?.tokens_used ?? "").toString()),
      ),
      FieldModel(
        title: 'Gpt version',
        type: FieldType.text,
        required: true,
        controller:
            TextEditingController(text: (item?.gpt_version ?? "").toString()),
      )
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'New message',
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, MessageModel? item,
      {bool isCreate = false}) async {
    final newModel = MessageModel(
        text: fields.firstWhere((i) => i.title == 'Text').controller?.text,
        role: fields.firstWhere((i) => i.title == 'Role').enumValue,
        is_checkin: fields.firstWhere((i) => i.title == 'Is checkin').value,
        checkin_id: int.tryParse(fields
                .firstWhere((i) => i.title == 'Checkin id')
                .controller
                ?.text ??
            '0'),
        user_category_id: int.tryParse(fields
                .firstWhere((i) => i.title == 'User-category id')
                .controller
                ?.text ??
            '0'),
        coach_id: int.tryParse(
            fields.firstWhere((i) => i.title == 'Coach id').controller?.text ??
                '0'),
        tokens_used: int.tryParse(
            fields.firstWhere((i) => i.title == 'Token used').controller?.text ??
                '0'),
        gpt_version:
            fields.firstWhere((i) => i.title == 'Gpt version').controller?.text ?? '',
        id: item?.id,
        time_create: item?.time_create);

    if (isCreate) {
      onCreate(context, newModel);
      return;
    }
    final res = await _messageRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(MessageModel? changed, MessageModel? newUser) {
    if (changed?.id == null) return;
    final messages = [...currentState.messages];
    final index = messages.indexWhere((users) => users?.id == newUser?.id);
    if (index == -1) {
      newUser
        ?..id = changed?.id
        ..time_create = changed?.time_create;
      messages.add(newUser);
    } else {
      messages.replaceRange(index, index + 1, [changed]);
    }
    setState(currentState.copyWith(messages: messages));
  }

  Future<void> onCreate(BuildContext context, MessageModel newModel) async {
    final requestModel = MessageRequestModel(
      text: newModel.text,
      role: newModel.role,
      is_checkin: newModel.is_checkin,
      checkin_id: newModel.checkin_id,
      user_category_id: newModel.user_category_id,
      coach_id: newModel.coach_id,
      tokens_used: newModel.tokens_used,
      gpt_version: newModel.gpt_version,
    );

    final res = await _messageRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }
}

class ScreenState {
  final bool loading;
  final List<MessageModel?> messages;
  final List<String>? titles;

  ScreenState(
      {this.loading = false, this.messages = const [], this.titles = const []});

  ScreenState copyWith(
      {bool? loading, List<MessageModel?>? messages, List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        messages: messages ?? this.messages,
        titles: titles ?? this.titles);
  }
}
