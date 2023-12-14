import 'package:totalis_admin/api/user_categories/dto.dart';
import 'package:totalis_admin/api/user_categories/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

class UserAndCategoryWidgetBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final UserCategoriesRequest _request = UserCategoriesRequest();

  UserAndCategoryWidgetBloc() {
    setState(ScreenState());
  }

  Future<void> init(int? id) async {
    setState(currentState.copyWith(loading: true));
    final res = await _request.get(id);
    setState(currentState.copyWith(loading: false, userCategory: res));
  }
}

class ScreenState {
  final bool loading;
  final UserCategoryModel? userCategory;

  ScreenState({this.loading = false, this.userCategory});

  ScreenState copyWith({bool? loading, UserCategoryModel? userCategory}) {
    return ScreenState(
        loading: loading ?? this.loading,
        userCategory: userCategory ?? this.userCategory);
  }
}
