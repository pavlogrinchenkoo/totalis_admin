import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/variable/dto.dart';
import 'package:totalis_admin/api/variable/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

class MessageBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final VariableRequest _variableRequest = VariableRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  MessageBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final variables = await _variableRequest.getAll();
    setState(currentState.copyWith(loading: false, variables: variables ?? []));
  }
}

class ScreenState {
  final bool loading;
  final List<VariableModel?> variables;
  final List<String>? titles;

  ScreenState(
      {this.loading = false,
      this.variables = const [],
      this.titles = const []});

  ScreenState copyWith(
      {bool? loading, List<VariableModel?>? variables, List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        variables: variables ?? this.variables,
        titles: titles ?? this.titles);
  }
}
