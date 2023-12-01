import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
import 'package:totalis_admin/api/models_chat_gpt/dto.dart';
import 'package:totalis_admin/api/models_chat_gpt/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/utils/custom_function.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class ModelsChatGptBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final ModelsChatGptRequest _modelRequest = ModelsChatGptRequest();
  final FilterRequest _filterRequest = FilterRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  ModelsChatGptBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    await uploadItems();
    setState(currentState.copyWith(loading: false));
  }

  Future<void> uploadItems(
      {int? page, bool? isAll, List<Filters?>? filters}) async {
    if (currentState.isAll && filters == null) return;
    final items = await _filterRequest.modelsFilters(QueryModel(
        page: page ?? currentState.page,
        count: 20,
        filters: filters ?? currentState.filters ?? []));
    if (items != null) {
      final List<ModelsChatGptModel?> newItems =
          page == 0 ? [...items] : [...currentState.models, ...items];
      final newIsAll = (items.length) < 20;
      setState(currentState.copyWith(
          models: newItems,
          page: (page ?? currentState.page) + 1,
          isAll: newIsAll));
    } else {
      setState(currentState.copyWith(isAll: true));
    }
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

  openChange(BuildContext context, ModelsChatGptModel? item) {
    final fields = [
      FieldModel(
        title: 'Value',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(text: (item?.value ?? "").toString()),
      ),
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'New model chat gpt',
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(
      BuildContext context, List<FieldModel> fields, ModelsChatGptModel? item,
      {bool isCreate = false}) async {
    final newModel = ModelsChatGptModel(
        value: fields.firstWhere((i) => i.title == 'Value').controller?.text,
        id: item?.id,
        time_create: item?.time_create);

    if (isCreate) {
      onCreate(context, newModel);
      return;
    }
    final res = await _modelRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(ModelsChatGptModel? changed, ModelsChatGptModel? newUser) {
    if (changed?.id == null) return;
    final models = [...currentState.models];
    final index = models.indexWhere((users) => users?.id == newUser?.id);
    if (index == -1) {
      newUser
        ?..id = changed?.id
        ..time_create = changed?.time_create;
      models.add(newUser);
    } else {
      models.replaceRange(index, index + 1, [changed]);
    }
    setState(currentState.copyWith(models: models));
  }

  Future<void> onCreate(
      BuildContext context, ModelsChatGptModel newModel) async {
    final requestModel = ModelsChatGptRequestModel(
      value: newModel.value,
    );

    final res = await _modelRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }
}

class ScreenState {
  final bool loading;
  final List<ModelsChatGptModel?> models;
  final List<String>? titles;
  final List<Filters?>? filters;
  final bool isAll;
  final int page;

  ScreenState(
      {this.loading = false,
      this.models = const [],
      this.titles = const [],
      this.filters = const [],
      this.isAll = false,
      this.page = 0});

  ScreenState copyWith(
      {bool? loading,
      List<ModelsChatGptModel?>? models,
      List<String>? titles,
      List<Filters?>? filters,
      bool? isAll,
      int? page}) {
    return ScreenState(
        loading: loading ?? this.loading,
        models: models ?? this.models,
        titles: titles ?? this.titles,
        filters: filters ?? this.filters,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page);
  }
}
