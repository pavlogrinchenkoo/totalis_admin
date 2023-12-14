import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
import 'package:totalis_admin/api/recommendation/dto.dart';
import 'package:totalis_admin/api/recommendation/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class RecommendationBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final RecommendationRequest _recommendationRequest = RecommendationRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();
  final FilterRequest _filterRequest = FilterRequest();

  RecommendationBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final recommendations = await _recommendationRequest.getAll();
    setState(currentState.copyWith(
        loading: false, recommendations: recommendations ?? []));
  }

  openChange(BuildContext context, RecommendationModel? item) {
    final fields = [
      FieldModel(
        title: 'Checkin id',
        type: FieldType.text,
        required: true,
        controller:
            TextEditingController(text: (item?.checkin_id ?? "").toString()),
      ),
      FieldModel(
        title: 'Text',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(text: item?.text),
      ),
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'New recommendation',
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(
      BuildContext context, List<FieldModel> fields, RecommendationModel? item,
      {bool isCreate = false}) async {
    final newModel = RecommendationModel(
        text: fields.firstWhere((i) => i.title == 'Text').controller?.text,
        checkin_id: int.tryParse(fields
                    .firstWhere((i) => i.title == 'Checkin id')
                    .controller
                    ?.text ??
                '') ??
            0,
        id: item?.id,
        time_create: item?.time_create);

    if (isCreate) {
      onCreate(context, newModel);
      return;
    }
    final res = await _recommendationRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(
      RecommendationModel? changed, RecommendationModel? newRecommendations) {
    if (changed?.id == null) return;
    final recommendations = [...currentState.recommendations];
    final index = recommendations
        .indexWhere((users) => users?.id == newRecommendations?.id);
    if (index == -1) {
      newRecommendations
        ?..id = changed?.id
        ..time_create = changed?.time_create;
      recommendations.add(newRecommendations);
    } else {
      recommendations.replaceRange(index, index + 1, [changed]);
    }
    setState(currentState.copyWith(recommendations: recommendations));
  }

  Future<void> onCreate(
      BuildContext context, RecommendationModel newModel) async {
    final requestModel = RecommendationRequestModel(
      text: newModel.text,
      checkin_id: newModel.checkin_id,
    );

    final res = await _recommendationRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  Future<void> uploadItems(
      {int? page, bool? isAll, List<Filters?>? filters}) async {
    if ((currentState.isAll && filters == null) || currentState.loadingMore) {
      return;
    }
    setState(currentState.copyWith(loadingMore: true));
    final items = await _filterRequest.recommendationFilters(QueryModel(
        page: page ?? currentState.page,
        count: 20,
        filters: filters ?? currentState.filters,
        orders: [Orders(field: 'id', desc: true)]));
    if (items != null) {
      final List<RecommendationModel?> newItems =
          page == 0 ? [...items] : [...currentState.recommendations, ...items];
      final newIsAll = (items.length) < 20;
      setState(currentState.copyWith(
          recommendations: newItems,
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
  final List<RecommendationModel?> recommendations;
  final List<String>? titles;
  final List<Filters?>? filters;
  final bool isAll;
  final int page;

  ScreenState(
      {this.loading = false,
      this.loadingMore = false,
      this.recommendations = const [],
      this.titles = const [],
      this.filters,
      this.isAll = false,
      this.page = 0});

  ScreenState copyWith(
      {bool? loading,
      bool? loadingMore,
      List<RecommendationModel?>? recommendations,
      List<String>? titles,
      List<Filters?>? filters,
      bool? isAll,
      int? page}) {
    return ScreenState(
        loading: loading ?? this.loading,
        loadingMore: loadingMore ?? this.loadingMore,
        recommendations: recommendations ?? this.recommendations,
        titles: titles ?? this.titles,
        filters: filters ?? this.filters,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page);
  }
}
