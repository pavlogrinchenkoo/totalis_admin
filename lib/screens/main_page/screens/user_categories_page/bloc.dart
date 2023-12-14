import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';
import 'package:totalis_admin/api/user_categories/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/utils/custom_function.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class UserCategoriesBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final UserCategoriesRequest _userCategoriesRequest = UserCategoriesRequest();
  final FilterRequest _filterRequest = FilterRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  UserCategoriesBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    await uploadItems();
    setState(currentState.copyWith(loading: false));
  }

  Future<void> uploadItems(
      {int? page, bool? isAll, List<Filters?>? filters}) async {
    if ((currentState.isAll && filters == null) || currentState.loadingMore) {
      return;
    }
    setState(currentState.copyWith(loadingMore: true));
    final items = await _filterRequest.userCategoryFilters(QueryModel(
        page: page ?? currentState.page,
        count: 20,
        filters: filters ?? currentState.filters));
    if (items != null) {
      final List<UserCategoryModel?> newItems =
          page == 0 ? [...items] : [...currentState.items, ...items];
      final newIsAll = (items.length) < 20;
      setState(currentState.copyWith(
          items: newItems,
          filters: filters ?? currentState.filters,
          page: (page ?? currentState.page) + 1,
          isAll: newIsAll));
    } else {
      setState(currentState.copyWith(isAll: true));
    }
    setState(currentState.copyWith(loadingMore: false));
  }

  onSearch(Filters? filters) async {
    if (filters == null) {
      setState(currentState..copyWith(filters: [], page: 0, isAll: false));
      uploadItems(page: 0, isAll: false, filters: []);
      return null;
    }
    final newFilters =
        containsInt(filters.field) || containsLevel(filters.value)
            ? Filters(field: filters.field, value: int.tryParse(filters.value))
            : filters;
    setState(
        currentState..copyWith(filters: [newFilters], page: 0, isAll: false));
    uploadItems(page: 0, isAll: false, filters: [newFilters]);
  }

  openChange(BuildContext context, UserCategoryModel? item, {Widget? widget}) {
    final fields = [
      FieldModel(
          title: 'User id',
          required: true,
          controller:
              TextEditingController(text: (item?.user_id ?? '').toString())),
      FieldModel(
          title: 'Category id',
          required: true,
          controller: TextEditingController(
              text: (item?.category_id ?? '').toString())),
      FieldModel(
          title: 'Is favorite',
          required: true,
          type: FieldType.checkbox,
          value: item?.is_favorite),
      FieldModel(
        title: 'Muted day',
        type: FieldType.dateTime,
        controller: TextEditingController(text: item?.muted_day),
      ),
      FieldModel(
        title: 'Muted for',
        type: FieldType.dateTime,
        controller: TextEditingController(text: item?.muted_day),
      ),
      FieldModel(
        title: 'Chat summary long',
        type: FieldType.text,
        enable: false,
        controller: TextEditingController(text: item?.chat_summary_long),
      ),
      FieldModel(
        title: 'Chat summary short',
        type: FieldType.text,
        enable: false,
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
        widget: widget,
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, UserCategoryModel? item,
      {bool isCreate = false}) async {
    final newModel = UserCategoryModel(
        user_id: int.tryParse(fields
                    .firstWhere((i) => i.title == 'User id')
                    .controller
                    ?.text ??
                '0') ??
            0,
        category_id: int.tryParse(fields
                    .firstWhere((i) => i.title == 'Category id')
                    .controller
                    ?.text ??
                '0') ??
            0,
        is_favorite: fields.firstWhere((i) => i.title == 'Is favorite').value,
        muted_day:
            fields.firstWhere((i) => i.title == 'Muted day').controller?.text,
        muted_for:
            fields.firstWhere((i) => i.title == 'Muted for').controller?.text,
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
    final admins = [...currentState.items];
    final index = admins.indexWhere((users) => users?.id == newUser?.id);
    if (index == -1) {
      newUser
        ?..id = changed?.id
        ..time_create = changed?.time_create;
      admins.add(newUser);
    } else {
      admins.replaceRange(index, index + 1, [changed]);
    }
    setState(currentState.copyWith(items: admins));
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

  Future<UserCategoryModel?> getUserCategory(int? id) async {
    if (id == null) return null;
    final res = await _userCategoriesRequest.get(id);
    return res;
  }

  Future<int?> getUserCategoryId(int? id) async {
    if (id == null) return null;
    final res = await _userCategoriesRequest.get(id);
    return res?.category_id;
  }
}

class ScreenState {
  final bool loading;
  final bool loadingMore;
  final List<UserCategoryModel?> items;
  final List<String>? titles;
  final List<Filters?>? filters;
  final bool isAll;
  final int page;

  ScreenState(
      {this.loading = false,
      this.loadingMore = false,
      this.items = const [],
      this.titles = const [],
      this.filters = const [],
      this.isAll = false,
      this.page = 0});

  ScreenState copyWith(
      {bool? loading,
      bool? loadingMore,
      List<UserCategoryModel?>? items,
      List<String>? titles,
      List<Filters?>? filters,
      bool? isAll,
      int? page}) {
    return ScreenState(
        loading: loading ?? this.loading,
        loadingMore: loadingMore ?? this.loadingMore,
        items: items ?? this.items,
        titles: titles ?? this.titles,
        filters: filters ?? this.filters,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page);
  }
}
