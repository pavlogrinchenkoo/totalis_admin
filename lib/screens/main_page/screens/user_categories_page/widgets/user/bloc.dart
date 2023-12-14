import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/api/user/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

class UserWidgetBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final UserRequest _request = UserRequest();

  UserWidgetBloc() {
    setState(ScreenState());
  }

  Future<void> init(int? id) async {
    setState(currentState.copyWith(loading: true));
    final res = await _request.get(id);
    setState(currentState.copyWith(loading: false, user: res));
  }
}

class ScreenState {
  final bool loading;
  final UserModel? user;

  ScreenState({this.loading = false, this.user});

  ScreenState copyWith({bool? loading, UserModel? user}) {
    return ScreenState(
        loading: loading ?? this.loading, user: user ?? this.user);
  }
}
