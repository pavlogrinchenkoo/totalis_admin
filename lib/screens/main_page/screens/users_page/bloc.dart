import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/api/user/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/utils/custom_function.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class UsersBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final UserRequest _userRequest = UserRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  UsersBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final users = await _userRequest.getAll();
    getTitles(items: users);
    setState(currentState.copyWith(loading: false, users: users ?? []));
  }

  getTitles({required List<dynamic>? items}) {
    final titles = getTitlesCustom(items: items);
    setState(currentState.copyWith(titles: titles));
  }

  changeIsTester(UserModel? item, bool isTester) async {
    if (item == null) return;
    final newUser = item;
    newUser.is_tester = isTester;
    final changed = await _userRequest.change(newUser);
    if (changed?.id == null) return;
    replaceItem(changed, newUser);
  }

  openChange(BuildContext context, UserModel? item) {
    final fields = [
      FieldModel(
          title: 'First name',
          controller: TextEditingController(text: item?.first_name)),
      FieldModel(
          title: 'Last name',
          controller: TextEditingController(text: item?.last_name)),
      FieldModel(
          title: 'Firebase uid',
          type: FieldType.text,
          enable: false,
          controller: TextEditingController(text: item?.firebase_uid)),
      // FieldModel(
      //     title: 'Avatar',
      //     type: FieldType.avatar,
      //     enable: false,
      //     controller: TextEditingController(text: item?.avatar)),
      FieldModel(
          title: 'Is tester', type: FieldType.checkbox, value: item?.is_tester),
      FieldModel(
          title: 'Sex',
          type: FieldType.text,
          controller: TextEditingController(text: item?.sex)),
      FieldModel(
          title: 'Birthday',
          type: FieldType.text,
          controller: TextEditingController(text: item?.birth)),
      FieldModel(
          title: 'Coach id',
          type: FieldType.text,
          controller:
              TextEditingController(text: (item?.coach_id ?? 0).toString())),
    ];
    context.router.push(ChangeRoute(
        fields: fields,
        title: 'User',
        onSave: () => {onSave(context, fields, item)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, UserModel? item) async {
    final newModel = UserModel(
        firebase_uid: item?.firebase_uid,
        id: item?.id,
        time_create: item?.time_create,
        first_name:
            fields.firstWhere((i) => i.title == 'First name').controller?.text,
        last_name:
            fields.firstWhere((i) => i.title == 'Last name').controller?.text,
        is_tester: fields.firstWhere((i) => i.title == 'Is tester').value,
        sex: fields.firstWhere((i) => i.title == 'Sex').controller?.text,
        birth: fields.firstWhere((i) => i.title == 'Birthday').controller?.text,
        coach_id: int.parse(
            fields.firstWhere((i) => i.title == 'Coach id').controller?.text ??
                '0'),
        avatar: item?.avatar);

    final res = await _userRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(UserModel? changed, UserModel? newUser) {
    if (changed?.id == null) return;
    final admins = [...currentState.users];
    final index = admins.indexWhere((users) => users?.id == newUser?.id);
    admins.replaceRange(index, index + 1, [changed]);
    setState(currentState.copyWith(users: admins));
  }
}

class ScreenState {
  final bool loading;
  final List<UserModel?> users;
  final List<String>? titles;

  ScreenState(
      {this.loading = false, this.users = const [], this.titles = const []});

  ScreenState copyWith(
      {bool? loading, List<UserModel?>? users, List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        users: users ?? this.users,
        titles: titles ?? this.titles);
  }
}
