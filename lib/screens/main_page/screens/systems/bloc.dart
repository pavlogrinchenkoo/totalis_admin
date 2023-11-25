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
    final system = await _systemRequest.get();
    setState(currentState.copyWith(loading: false, system: system));
  }

  openChange(BuildContext context, SystemModel? item) {
    final fields = [
      FieldModel(
        title: 'Openapi key',
        type: FieldType.text,
        controller: TextEditingController(text: item?.openapi_key),
      ),
      FieldModel(
        title: 'Model gpt version',
        type: FieldType.text,
        controller: TextEditingController(text: item?.model_gpt_version),
      ),
      FieldModel(
        title: 'Prompt why',
        type: FieldType.bigText,
        controller: TextEditingController(text: item?.prompt_why),
      ),
      FieldModel(
        title: 'Prompt how',
        type: FieldType.bigText,
        controller: TextEditingController(text: item?.prompt_how),
      ),
      FieldModel(
        title: 'Model temperature',
        type: FieldType.text,
        controller: TextEditingController(
            text: (item?.model_temperature ?? 0).toString()),
      ),
      FieldModel(
        title: 'Model max response token',
        type: FieldType.text,
        controller: TextEditingController(
            text: (item?.model_max_response_token ?? '').toString()),
      ),
      FieldModel(
        title: 'Model presence penalty',
        type: FieldType.text,
        controller: TextEditingController(
            text: (item?.model_presence_penalty ?? '').toString()),
      ),
      FieldModel(
        title: 'Model frequency penalty',
        type: FieldType.text,
        controller: TextEditingController(
            text: (item?.model_frequency_penalty ?? '').toString()),
      ),
      FieldModel(
        title: 'Context limit',
        type: FieldType.text,
        controller:
            TextEditingController(text: (item?.context_limit ?? '').toString()),
      ),
      FieldModel(
        title: 'Show msg history',
        type: FieldType.text,
        controller: TextEditingController(
            text: (item?.show_msg_history ?? '').toString()),
      ),
      FieldModel(
        title: 'Summarize frequency',
        type: FieldType.text,
        controller: TextEditingController(
            text: (item?.summarize_frequency ?? '').toString()),
      ),
      FieldModel(
        title: 'Test days forward',
        type: FieldType.text,
        controller: TextEditingController(
            text: (item?.test_days_forward ?? '').toString()),
      ),
      FieldModel(
        title: 'Login timeout',
        type: FieldType.text,
        controller:
            TextEditingController(text: (item?.login_timeout ?? '').toString()),
      ),
      FieldModel(
        title: 'Message cache',
        type: FieldType.text,
        controller:
            TextEditingController(text: (item?.message_cache ?? '').toString()),
      ),
    ];

    context.router.push(ChangeRoute(
        fields: fields,
        title: 'Change system',
        onSave: () => {onSave(context, fields, item)}));
  }

  onSave(
      BuildContext context, List<FieldModel> fields, SystemModel? item) async {
    final newModel = SystemModel(
        openapi_key:
            fields.firstWhere((i) => i.title == 'Openapi key').controller?.text,
        model_gpt_version: fields
            .firstWhere((i) => i.title == 'Model gpt version')
            .controller
            ?.text,
        prompt_why:
            fields.firstWhere((i) => i.title == 'Prompt why').controller?.text,
        prompt_how:
            fields.firstWhere((i) => i.title == 'Prompt how').controller?.text,
        model_temperature: int.parse(fields
                .firstWhere((i) => i.title == 'Model temperature')
                .controller
                ?.text ??
            '0'),
        model_max_response_token: int.parse(fields
                .firstWhere((i) => i.title == 'Model max response token')
                .controller
                ?.text ??
            '0'),
        model_presence_penalty: int.parse(fields
                .firstWhere((i) => i.title == 'Model presence penalty')
                .controller
                ?.text ??
            '0'),
        model_frequency_penalty: int.parse(
            fields.firstWhere((i) => i.title == 'Model frequency penalty').controller?.text ?? '0'),
        context_limit: int.parse(fields.firstWhere((i) => i.title == 'Context limit').controller?.text ?? '0'),
        show_msg_history: int.parse(fields.firstWhere((i) => i.title == 'Show msg history').controller?.text ?? '0'),
        summarize_frequency: int.parse(fields.firstWhere((i) => i.title == 'Summarize frequency').controller?.text ?? '0'),
        test_days_forward: int.parse(fields.firstWhere((i) => i.title == 'Test days forward').controller?.text ?? '0'),
        login_timeout: int.parse(fields.firstWhere((i) => i.title == 'Login timeout').controller?.text ?? '0'),
        message_cache: int.parse(fields.firstWhere((i) => i.title == 'Message cache').controller?.text ?? '0'),
        id: item?.id,
        time_create: item?.time_create);

    final res = await _systemRequest.change(newModel);
    if (context.mounted) context.router.pop();
    setState(currentState.copyWith(system: res));
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
