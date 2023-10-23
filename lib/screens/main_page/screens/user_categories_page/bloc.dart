import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';
import 'package:totalis_admin/api/user_categories/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class UserCategoriesBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final UserCategoriesRequest _userCategoriesRequest = UserCategoriesRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  UserCategoriesBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final userCategories = await _userCategoriesRequest.getAll();
    setState(currentState.copyWith(
        loading: false, userCategories: userCategories ?? []));
  }

  changeIsFavorite(UserCategoryModel? item, bool value) async {
    if (item == null) return;
    final newUserCategory = item;
    newUserCategory.is_favorite = value;
    final changed = await _userCategoriesRequest.change(newUserCategory);
    if (changed?.id == null) return;
    replaceItem(changed, newUserCategory);
  }

  openChange(BuildContext context, UserCategoryModel? item) {
    final fields = [
      FieldModel(
          title: 'User id',
          controller:
              TextEditingController(text: (item?.user_id ?? 0).toString())),
      FieldModel(
          title: 'Category id',
          controller:
              TextEditingController(text: (item?.category_id ?? 0).toString())),
      FieldModel(
          title: 'Is favorite',
          type: FieldType.checkbox,
          value: item?.is_favorite),
      FieldModel(
        title: 'Muted day',
        type: FieldType.text,
        controller: TextEditingController(text: item?.muted_day),
      ),
      FieldModel(
        title: 'Muted for',
        type: FieldType.text,
        controller:
            TextEditingController(text: (item?.muted_for ?? 0).toString()),
      ),
      FieldModel(
        title: 'Chat summary long',
        type: FieldType.bigText,
        controller: TextEditingController(text: item?.chat_summary_long),
      ),
      FieldModel(
        title: 'Chat summary short',
        type: FieldType.bigText,
        controller: TextEditingController(text: item?.chat_summary_short),
      ),
      FieldModel(
          title: 'User chat', type: FieldType.checkbox, value: item?.used_chat),
      FieldModel(
          title: 'Is read', type: FieldType.checkbox, value: item?.is_read),
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'User category',
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, UserCategoryModel? item,
      {bool isCreate = false}) async {
    final newModel = UserCategoryModel(
        user_id: int.parse(
            fields.firstWhere((i) => i.title == 'User id').controller?.text ??
                '0'),
        category_id: int.parse(fields
                .firstWhere((i) => i.title == 'Category id')
                .controller
                ?.text ??
            '0'),
        is_favorite: fields.firstWhere((i) => i.title == 'Is favorite').value,
        muted_day:
            fields.firstWhere((i) => i.title == 'Muted day').controller?.text,
        muted_for: int.tryParse(
            fields.firstWhere((i) => i.title == 'Muted for').controller?.text ??
                '0'),
        chat_summary_long: fields
            .firstWhere((i) => i.title == 'Chat summary long')
            .controller
            ?.text,
        chat_summary_short: fields
            .firstWhere((i) => i.title == 'Chat summary short')
            .controller
            ?.text,
        used_chat: fields.firstWhere((i) => i.title == 'User chat').value,
        is_read: fields.firstWhere((i) => i.title == 'Is read').value,
        id: item?.id,
        time_create: item?.time_create);

    if (isCreate) {
      onCreate(context, newModel);
      return;
    }
    final res = await _userCategoriesRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(UserCategoryModel? changed, UserCategoryModel? newUser) {
    if (changed?.id == null) return;
    final admins = [...currentState.userCategories];
    final index = admins.indexWhere((users) => users?.id == newUser?.id);
    if (index == -1) {
      newUser
        ?..id = changed?.id
        ..time_create = changed?.time_create;
      admins.add(newUser);
    } else {
      admins.replaceRange(index, index + 1, [changed]);
    }
    setState(currentState.copyWith(userCategories: admins));
  }

  Future<void> onCreate(
      BuildContext context, UserCategoryModel newModel) async {
    final requestModel = UserCategoryRequestModel(
        user_id: newModel.user_id,
        category_id: newModel.category_id,
        is_favorite: newModel.is_favorite ?? false,
        muted_day: newModel.muted_day,
        muted_for: newModel.muted_for,
        chat_summary_long: newModel.chat_summary_long,
        chat_summary_short: newModel.chat_summary_short,
        used_chat: newModel.used_chat ?? false,
        is_read: newModel.is_read ?? true);

    final res = await _userCategoriesRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }
}

class ScreenState {
  final bool loading;
  final List<UserCategoryModel?> userCategories;
  final List<String>? titles;

  ScreenState(
      {this.loading = false,
      this.userCategories = const [],
      this.titles = const []});

  ScreenState copyWith(
      {bool? loading,
      List<UserCategoryModel?>? userCategories,
      List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        userCategories: userCategories ?? this.userCategories,
        titles: titles ?? this.titles);
  }
}
