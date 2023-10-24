import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/api/categories/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class CategoriesBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final CategoriesRequest _categoriesRequest = CategoriesRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  CategoriesBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final categories = await _categoriesRequest.getAll();
    setState(
        currentState.copyWith(loading: false, categories: categories ?? []));
  }

  changeIsHome(CategoryModel? item, bool value) async {
    if (item == null) return;
    final newCategory = item;
    newCategory.is_home = value;
    final changed = await _categoriesRequest.change(newCategory);
    if (changed?.id == null) return;
    replaceItem(changed, newCategory);
  }

  openChange(BuildContext context, CategoryModel? item) {
    final fields = [
      FieldModel(
          title: 'Parent id',
          controller: TextEditingController(
              text: ((item?.parent_id) ?? "").toString())),
      FieldModel(
          title: 'Name', controller: TextEditingController(text: item?.name)),
      FieldModel(
          title: 'Icon id',
          controller:
              TextEditingController(text: (item?.icon_id ?? 0).toString())),
      FieldModel(
          title: 'Sorted order',
          controller:
              TextEditingController(text: (item?.sort_order ?? 0).toString())),
      FieldModel(
          title: 'Description',
          controller: TextEditingController(text: item?.description)),
      FieldModel(
          title: 'Is home', type: FieldType.checkbox, value: item?.is_home),
      FieldModel(
        title: 'Subcategories title',
        type: FieldType.text,
        controller: TextEditingController(text: item?.subcategories_title),
      ),
      FieldModel(
          title: 'Show checkin history',
          type: FieldType.checkbox,
          value: item?.show_checkin_history),
      FieldModel(
          title: 'Checkin enabled',
          type: FieldType.checkbox,
          value: item?.checkin_enabled),
      FieldModel(
        title: 'Guidelines file link',
        type: FieldType.text,
        controller: TextEditingController(text: item?.guidelines_file_link),
      ),
      FieldModel(
        title: 'Prompt',
        type: FieldType.text,
        controller: TextEditingController(text: item?.prompt),
      ),
      FieldModel(
        title: 'Prompt checkin',
        type: FieldType.text,
        controller: TextEditingController(text: item?.prompt_checkin),
      ),
      FieldModel(
        title: 'Prompt followup',
        type: FieldType.text,
        controller: TextEditingController(text: item?.prompt_followup),
      ),
      FieldModel(
        title: 'Followup chat enabled',
        type: FieldType.checkbox,
        value: item?.followup_chat_enabled,
      ),
      FieldModel(
        title: 'Followup timer',
        type: FieldType.text,
        controller:
            TextEditingController(text: item?.followup_timer.toString()),
      )
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'Category',
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, CategoryModel? item,
      {bool isCreate = false}) async {
    final newModel = CategoryModel(
        parent_id: int.tryParse(
            fields.firstWhere((i) => i.title == 'Parent id').controller?.text ??
                '0'),
        id: item?.id,
        time_create: item?.time_create,
        name: fields.firstWhere((i) => i.title == 'Name').controller?.text,
        icon_id: int.parse(
            fields.firstWhere((i) => i.title == 'Icon id').controller?.text ??
                '0'),
        sort_order: int.parse(
            fields.firstWhere((i) => i.title == 'Icon id').controller?.text ??
                '0'),
        description:
            fields.firstWhere((i) => i.title == 'Description').controller?.text,
        is_home: fields.firstWhere((i) => i.title == 'Is home').value,
        subcategories_title: fields
            .firstWhere((i) => i.title == 'Subcategories title')
            .controller
            ?.text,
        show_checkin_history:
            fields.firstWhere((i) => i.title == 'Show checkin history').value ??
                false,
        checkin_enabled:
            fields.firstWhere((i) => i.title == 'Checkin enabled').value ?? false,
        guidelines_file_link: fields.firstWhere((i) => i.title == 'Guidelines file link').controller?.text ?? '',
        prompt: fields.firstWhere((i) => i.title == 'Prompt').controller?.text ?? '',
        prompt_checkin: fields.firstWhere((i) => i.title == 'Prompt checkin').controller?.text ?? '',
        prompt_followup: fields.firstWhere((i) => i.title == 'Prompt followup').controller?.text ?? '',
        followup_chat_enabled: fields.firstWhere((i) => i.title == 'Followup chat enabled').value,
        followup_timer: int.tryParse(fields.firstWhere((i) => i.title == 'Followup timer').controller?.text ?? '0'));

    if (isCreate) {
      onCreate(context, newModel);
      return;
    }
    final res = await _categoriesRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(CategoryModel? changed, CategoryModel? newUser) {
    if (changed?.id == null) return;
    final admins = [...currentState.categories];
    final index = admins.indexWhere((users) => users?.id == newUser?.id);
    if (index == -1) {
      newUser
        ?..id = changed?.id
        ..time_create = changed?.time_create;
      admins.add(newUser);
    } else {
      admins.replaceRange(index, index + 1, [changed]);
    }
    setState(currentState.copyWith(categories: admins));
  }

  Future<void> onCreate(BuildContext context, CategoryModel newModel) async {
    final requestModel = CategoryModelRequest(
        parent_id: newModel.parent_id,
        name: newModel.name,
        icon_id: newModel.icon_id,
        sort_order: newModel.sort_order,
        description: newModel.description,
        is_home: newModel.is_home ?? false,
        subcategories_title: newModel.subcategories_title,
        show_checkin_history: newModel.show_checkin_history,
        checkin_enabled: newModel.checkin_enabled,
        guidelines_file_link: newModel.guidelines_file_link,
        prompt: newModel.prompt,
        prompt_checkin: newModel.prompt_checkin,
        prompt_followup: newModel.prompt_followup,
        followup_chat_enabled: newModel.followup_chat_enabled,
        followup_timer: newModel.followup_timer);

    final res = await _categoriesRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }
}

class ScreenState {
  final bool loading;
  final List<CategoryModel?> categories;
  final List<String>? titles;

  ScreenState(
      {this.loading = false,
      this.categories = const [],
      this.titles = const []});

  ScreenState copyWith(
      {bool? loading, List<CategoryModel?>? categories, List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        categories: categories ?? this.categories,
        titles: titles ?? this.titles);
  }
}
