import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
}

class ScreenState {
  final bool loading;
  final List<RecommendationModel?> recommendations;
  final List<String>? titles;

  ScreenState(
      {this.loading = false,
      this.recommendations = const [],
      this.titles = const []});

  ScreenState copyWith(
      {bool? loading,
      List<RecommendationModel?>? recommendations,
      List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        recommendations: recommendations ?? this.recommendations,
        titles: titles ?? this.titles);
  }
}
