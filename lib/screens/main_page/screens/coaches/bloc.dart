import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/coaches/dto.dart';
import 'package:totalis_admin/api/coaches/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

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
