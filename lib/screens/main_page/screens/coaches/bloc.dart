import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/coaches/dto.dart';
import 'package:totalis_admin/api/coaches/request.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
import 'package:totalis_admin/api/user/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class CoachesBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final CoachesRequest _coachesRequest = CoachesRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();
  final FilterRequest _filterRequest = FilterRequest();

  CoachesBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    await uploadItems();
    setState(currentState.copyWith(loading: false));
  }

  openChange(BuildContext context, CoachesModel? item) {
    final fields = [
      FieldModel(
        title: 'Name',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(text: item?.name),
      ),
      FieldModel(
        title: 'Prompt',
        required: true,
        type: FieldType.bigText,
        controller: TextEditingController(text: item?.prompt),
      ),
      FieldModel(
        title: 'Description',
        required: true,
        type: FieldType.bigText,
        controller: TextEditingController(text: item?.description),
      ),
      FieldModel(
        title: 'Avatar',
        type: FieldType.avatar,
        imageId: item?.image_id,
      ),
      FieldModel(
        title: 'Sex',
        type: FieldType.enums,
        enumValue: item?.sex,
        values: SexEnum.values,
        required: true,
      ),
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'Coach',
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, CoachesModel? item,
      {bool isCreate = false}) async {
    final newModel = CoachesModel(
        name: fields.firstWhere((i) => i.title == 'Name').controller?.text,
        prompt: fields.firstWhere((i) => i.title == 'Prompt').controller?.text,
        description:
            fields.firstWhere((i) => i.title == 'Description').controller?.text,
        image_id: fields.firstWhere((i) => i.title == 'Avatar').imageId,
        sex: fields.firstWhere((i) => i.title == 'Sex').enumValue,
        // avatar: "",
        id: item?.id,
        time_create: item?.time_create);

    if (isCreate) {
      onCreate(context, newModel);
      return;
    }
    final res = await _coachesRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(CoachesModel? changed, CoachesModel? newCoach) {
    if (changed?.id == null) return;
    final coaches = [...currentState.coaches];
    final index = coaches.indexWhere((users) => users?.id == newCoach?.id);
    if (index == -1) {
      newCoach
        ?..id = changed?.id
        ..time_create = changed?.time_create;
      coaches.add(newCoach);
    } else {
      coaches.replaceRange(index, index + 1, [changed]);
    }
    setState(currentState.copyWith(coaches: coaches));
  }

  Future<void> onCreate(BuildContext context, CoachesModel newModel) async {
    final requestModel = CoachesRequestModel(
      prompt: newModel.prompt,
      description: newModel.description,
      name: newModel.name,
      image_id: newModel.image_id,
    );

    final res = await _coachesRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  Future<void> uploadItems(
      {int? page, bool? isAll, List<Filters?>? filters}) async {
    if ((currentState.isAll && filters == null) || currentState.loadingMore) {
      return;
    }
    setState(currentState.copyWith(loadingMore: true));
    final items = await _filterRequest.coachesFilters(QueryModel(
        page: page ?? currentState.page,
        count: 20,
        filters: filters ?? currentState.filters,
        orders: [Orders(field: 'id', desc: true)]));
    if (items != null) {
      final List<CoachesModel?> newItems = page == 0
          ? [...items]
          : [
              ...currentState.coaches,
              ...items,
              ...items,
              ...items,
              ...items,
              ...items,
              ...items,
              ...items
            ];
      final newIsAll = (items.length) < 20;
      setState(currentState.copyWith(
          coaches: newItems,
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
  final List<CoachesModel?> coaches;
  final List<String>? titles;
  final List<Filters?>? filters;
  final bool isAll;
  final int page;

  ScreenState(
      {this.loading = false,
      this.loadingMore = false,
      this.coaches = const [],
      this.titles = const [],
      this.filters = const [],
      this.isAll = false,
      this.page = 0});

  ScreenState copyWith(
      {bool? loading,
      bool? loadingMore,
      List<CoachesModel?>? coaches,
      List<String>? titles,
      List<Filters?>? filters,
      bool? isAll,
      int? page}) {
    return ScreenState(
        loading: loading ?? this.loading,
        loadingMore: loadingMore ?? this.loadingMore,
        coaches: coaches ?? this.coaches,
        titles: titles ?? this.titles,
        filters: filters ?? this.filters,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page);
  }
}
