import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
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
  final FilterRequest _filterRequest = FilterRequest();

  UsersBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    await uploadItems();
    setState(currentState.copyWith(loading: false));
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
          required: true,
          controller: TextEditingController(text: item?.firebase_uid)),
      FieldModel(
          title: 'Avatar', type: FieldType.avatar, imageId: item?.image_id),
      FieldModel(
          title: 'Is tester',
          type: FieldType.checkbox,
          value: item?.is_tester,
          enable: false),
      FieldModel(
          title: 'Sex',
          type: FieldType.enums,
          required: true,
          values: SexEnum.values,
          enumValue: item?.sex),
      FieldModel(
          title: 'Birthday',
          type: FieldType.dateTime,
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
        onDelete: () => onDelete(context, item),
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, UserModel? item,
      {bool isCreate = false}) async {
    final newModel = UserModel(
        firebase_uid: item?.firebase_uid,
        id: item?.id,
        time_create: item?.time_create,
        first_name:
            fields.firstWhere((i) => i.title == 'First name').controller?.text,
        last_name:
            fields.firstWhere((i) => i.title == 'Last name').controller?.text,
        is_tester:
            fields.firstWhere((i) => i.title == 'Is tester').value ?? false,
        sex: fields.firstWhere((i) => i.title == 'Sex').enumValue,
        birth: fields.firstWhere((i) => i.title == 'Birthday').controller?.text,
        coach_id: int.parse(
            fields.firstWhere((i) => i.title == 'Coach id').controller?.text ??
                '0'),
        image_id: fields.firstWhere((i) => i.title == 'Avatar').imageId);

    if (isCreate) {
      onCreate(context, newModel);
      return;
    }

    final res = await _userRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  Future<void> onCreate(BuildContext context, UserModel newModel) async {
    final requestModel = UserRequestModel(
      firebase_uid: newModel.firebase_uid,
      first_name: newModel.first_name,
      last_name: newModel.last_name,
      is_tester: newModel.is_tester ?? false,
      sex: newModel.sex,
      birth: newModel.birth,
      image_id: newModel.image_id,
      coach_id: newModel.coach_id,
    );

    final res = await _userRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(UserModel? changed, UserModel? newUser) {
    // if (changed?.id == null) return;
    final admins = [...currentState.users];
    final index = admins.indexWhere((users) => users?.id == newUser?.id);
    if (changed == null) {
      admins.removeAt(index);
    } else {
      admins.replaceRange(index, index + 1, [changed]);
    }
    setState(currentState.copyWith(users: admins));
  }

  Future<UserModel?> getUser(int? id) async {
    final res = await _userRequest.get(id);
    return res;
  }

  onDelete(BuildContext context, UserModel? item) async {
    showCustomDialog(context, DialogType.error, () async {
      final res = await _userRequest.delete(item?.id);
      if (context.mounted && res != null) context.router.pop();
      replaceItem(null, item);
    }, () => context.router.pop());
  }

  Future<void> uploadItems(
      {int? page, bool? isAll, List<Filters?>? filters}) async {
    if ((currentState.isAll && filters == null) || currentState.loadingMore) {
      return;
    }
    setState(currentState.copyWith(loadingMore: true));
    final items = await _filterRequest.userFilters(QueryModel(
        page: page ?? currentState.page,
        count: 20,
        filters: filters ?? currentState.filters,
        orders: [Orders(field: 'id', desc: true)]));
    if (items != null) {
      final List<UserModel?> newItems =
          page == 0 ? [...items] : [...currentState.users, ...items];
      final newIsAll = (items.length) < 20;
      setState(currentState.copyWith(
          users: newItems,
          filters: filters ?? currentState.filters,
          page: (page ?? currentState.page) + 1,
          isAll: newIsAll));
    } else {
      setState(currentState.copyWith(isAll: true));
    }
    setState(currentState.copyWith(loadingMore: false));
  }
}

class ScreenState {
  final bool loading;
  final bool loadingMore;
  final List<UserModel?> users;
  final List<Filters?>? filters;
  final bool isAll;
  final int page;

  ScreenState(
      {this.loading = false,
      this.loadingMore = false,
      this.users = const [],
      this.filters = const [],
      this.isAll = false,
      this.page = 0});

  ScreenState copyWith(
      {bool? loading,
      bool? loadingMore,
      List<UserModel?>? users,
      List<Filters?>? filters,
      bool? isAll,
      int? page}) {
    return ScreenState(
        loading: loading ?? this.loading,
        loadingMore: loadingMore ?? this.loadingMore,
        users: users ?? this.users,
        filters: filters ?? this.filters,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page);
  }
}
