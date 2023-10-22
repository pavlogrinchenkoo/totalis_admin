import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/api/user/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/utils/custom_function.dart';

class UsersBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final UserRequest _userRequest = UserRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  UsersBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final users = await _userRequest.getUsers();
    getTitles(items: users);
    setState(currentState.copyWith(loading: false, users: users ?? []));
  }

  getTitles({required List<dynamic>? items}) {
    final titles = getTitlesCustom(items: items);
    setState(currentState.copyWith(titles: titles));
  }

  changeIsTester(UserModel? item, bool isTester) async {
    if (item == null) return;
    final newUser = item;
    newUser.is_tester = isTester;
    final changed = await _userRequest.changeUser(newUser);
    if (changed?.id == null) return;
    final users = [...currentState.users];
    final index = users.indexWhere((user) => user?.id == newUser.id);
    users.replaceRange(index, index + 1, [changed]);
    setState(currentState.copyWith(users: users));
  }
}

class ScreenState {
  final bool loading;
  final List<UserModel?> users;
  final List<String>? titles;

  ScreenState(
      {this.loading = false, this.users = const [], this.titles = const []});

  ScreenState copyWith(
      {bool? loading, List<UserModel?>? users, List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        users: users ?? this.users,
        titles: titles ?? this.titles);
  }
}
