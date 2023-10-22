import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/api/check_ins/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

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
    setState(currentState.copyWith(loading: false, checkin: coaches ?? []));
  }
}

class ScreenState {
  final bool loading;
  final List<CheckInModel?> checkin;
  final List<String>? titles;

  ScreenState(
      {this.loading = false, this.checkin = const [], this.titles = const []});

  ScreenState copyWith(
      {bool? loading, List<CheckInModel?>? checkin, List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        checkin: checkin ?? this.checkin,
        titles: titles ?? this.titles);
  }
}
