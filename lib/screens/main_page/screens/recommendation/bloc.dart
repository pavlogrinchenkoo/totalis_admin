import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/api/recommendation/dto.dart';
import 'package:totalis_admin/api/recommendation/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

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
