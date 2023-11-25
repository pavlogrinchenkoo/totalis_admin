import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/api/check_ins/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class CheckInsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final CheckInsRequest _checkInsRequest = CheckInsRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  CheckInsBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final coaches = await _checkInsRequest.getAll();
    setState(currentState.copyWith(loading: false, checkins: coaches ?? []));
  }

  openChange(BuildContext context, CheckInModel? item) {
    final fields = [
      FieldModel(
        title: 'User category id',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(
            text: (item?.user_category_id ?? "").toString()),
      ),
      FieldModel(
        title: 'Level',
        type: FieldType.text,
        controller: TextEditingController(text: (item?.level ?? "").toString()),
      ),
      FieldModel(
        title: 'Date',
        type: FieldType.dateTime,
        required: true,
        controller: TextEditingController(text: item?.date),
      ),
      FieldModel(
        title: 'Summary',
        type: FieldType.bigText,
        controller: TextEditingController(text: item?.summary),
      ),
      FieldModel(
        title: 'Full text',
        type: FieldType.bigText,
        controller: TextEditingController(text: item?.full_text),
      ),
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'Сheck-In',
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, CheckInModel? item,
      {bool isCreate = false}) async {
    final newModel = CheckInModel(
        user_category_id: int.tryParse(fields
                    .firstWhere((i) => i.title == 'User category id')
                    .controller
                    ?.text ??
                '') ??
            0,
        level: int.tryParse(
                fields.firstWhere((i) => i.title == 'Level').controller?.text ??
                    '') ??
            0,
        date: fields.firstWhere((i) => i.title == 'Date').controller?.text,
        summary:
            fields.firstWhere((i) => i.title == 'Summary').controller?.text,
        full_text:
            fields.firstWhere((i) => i.title == 'Full text').controller?.text,
        id: item?.id,
        time_create: item?.time_create);

    if (isCreate) {
      onCreate(context, newModel);
      return;
    }
    final res = await _checkInsRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(CheckInModel? changed, CheckInModel? newCheckIn) {
    if (changed?.id == null) return;
    final coaches = [...currentState.checkins];
    final index = coaches.indexWhere((users) => users.id == newCheckIn?.id);
    if (index == -1) {
      newCheckIn
        ?..id = changed?.id
        ..time_create = changed?.time_create;
      if (newCheckIn == null) return;
      coaches.add(newCheckIn);
    } else {
      if (changed == null) return;
      coaches.replaceRange(index, index + 1, [changed]);
    }
    setState(currentState.copyWith(checkins: coaches));
  }

  Future<void> onCreate(BuildContext context, CheckInModel newModel) async {
    final requestModel = CheckInRequestModel(
      date: newModel.date,
      full_text: newModel.full_text,
      level: newModel.level,
      summary: newModel.summary,
      user_category_id: newModel.user_category_id,
    );

    final res = await _checkInsRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  initCheckins(int? id) async {
    final CheckInsRequest checkInsRequest = CheckInsRequest();
    final checkins = await checkInsRequest.getFromUserCategory(id ?? 0);
    setState(currentState.copyWith(checkins: checkins ?? []));
  }

  Future<CheckInModel?> getCheckIn(int? id) async {
    if(id == null) return null;
    final res = await _checkInsRequest.get(id.toString());
    return res;
  }
}

class ScreenState {
  final bool loading;
  final List<CheckInModel> checkins;
  final List<String>? titles;

  ScreenState(
      {this.loading = false, this.checkins = const [], this.titles = const []});

  ScreenState copyWith(
      {bool? loading, List<CheckInModel>? checkins, List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        checkins: checkins ?? this.checkins,
        titles: titles ?? this.titles);
  }
}
