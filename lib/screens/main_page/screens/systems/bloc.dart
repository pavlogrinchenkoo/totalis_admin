import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/system/dto.dart';
import 'package:totalis_admin/api/system/request.dart';
import 'package:totalis_admin/api/variable/dto.dart';
import 'package:totalis_admin/api/variable/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class SystemBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final VariableRequest _variableRequest = VariableRequest();
  final SystemRequest _systemRequest = SystemRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  SystemBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final variables = await _variableRequest.getAll();
    final system = await _systemRequest.get();
    setState(currentState.copyWith(
        loading: false, variables: variables ?? [], system: system?.first));
  }

  openChange(BuildContext context, VariableModel? item) {
    final fields = [
      FieldModel(
        title: 'Name',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(text: item?.name),
      ),
      FieldModel(
        title: 'Value',
        type: FieldType.text,
        required: true,
        controller: TextEditingController(text: item?.value),
      ),
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'New variable',
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, VariableModel? item,
      {bool isCreate = false}) async {
    final newModel = VariableModel(
        name: fields.firstWhere((i) => i.title == 'Name').controller?.text,
        value: fields.firstWhere((i) => i.title == 'Value').controller?.text,
        id: item?.id,
        time_create: item?.time_create);

    if (isCreate) {
      onCreate(context, newModel);
      return;
    }
    final res = await _variableRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(VariableModel? changed, VariableModel? newVariable) {
    if (changed?.id == null) return;
    final variables = [...currentState.variables];
    final index = variables.indexWhere((users) => users?.id == newVariable?.id);
    if (index == -1) {
      newVariable
        ?..id = changed?.id
        ..time_create = changed?.time_create;
      variables.add(newVariable);
    } else {
      variables.replaceRange(index, index + 1, [changed]);
    }
    setState(currentState.copyWith(variables: variables));
  }

  Future<void> onCreate(BuildContext context, VariableModel newModel) async {
    final requestModel = VariableRequestModel(
      value: newModel.value,
      name: newModel.name,
    );

    final res = await _variableRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }
}

class ScreenState {
  final bool loading;
  final List<VariableModel?> variables;
  final SystemModel? system;
  final List<String>? titles;

  ScreenState(
      {this.loading = false,
      this.variables = const [],
      this.system,
      this.titles = const []});

  ScreenState copyWith(
      {bool? loading,
      List<VariableModel?>? variables,
      SystemModel? system,
      List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        variables: variables ?? this.variables,
        system: system ?? this.system,
        titles: titles ?? this.titles);
  }
}
