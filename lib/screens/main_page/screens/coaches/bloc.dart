import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/coaches/dto.dart';
import 'package:totalis_admin/api/coaches/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class CoachesBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final CoachesRequest _coachesRequest = CoachesRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  CoachesBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final coaches = await _coachesRequest.getAll();
    setState(currentState.copyWith(loading: false, coaches: coaches ?? []));
  }

  openChange(BuildContext context, CoachesModel? item) {
    final fields = [
      FieldModel(
        title: 'Name',
        type: FieldType.text,
        controller: TextEditingController(text: item?.name),
      ),
      FieldModel(
        title: 'Prompt',
        type: FieldType.bigText,
        controller: TextEditingController(text: item?.prompt),
      ),
      FieldModel(
        title: 'Description',
        type: FieldType.bigText,
        controller: TextEditingController(text: item?.description),
      ),
      FieldModel(
        title: 'Avatar',
        type: FieldType.avatar,
        controller: TextEditingController(text: item?.description),
      ),
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'New coach',
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
        // avatar: fields.firstWhere((i) => i.title == 'Avatar').base64,
        avatar: "",
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
      avatar: newModel.avatar,
    );

    final res = await _coachesRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }
}

class ScreenState {
  final bool loading;
  final List<CoachesModel?> coaches;
  final List<String>? titles;

  ScreenState(
      {this.loading = false, this.coaches = const [], this.titles = const []});

  ScreenState copyWith(
      {bool? loading, List<CoachesModel?>? coaches, List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        coaches: coaches ?? this.coaches,
        titles: titles ?? this.titles);
  }
}
