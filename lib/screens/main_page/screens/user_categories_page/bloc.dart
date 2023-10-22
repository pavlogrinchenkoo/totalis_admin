import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';
import 'package:totalis_admin/api/user_categories/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

class UserCategoriesBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final UserCategoriesRequest _userCategoriesRequest = UserCategoriesRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  UserCategoriesBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final userCategories = await _userCategoriesRequest.getAll();
    setState(currentState.copyWith(
        loading: false, userCategories: userCategories ?? []));
  }

  changeIsFavorite(UserCategoryModel? item, bool value) async {
    if (item == null) return;
    final newUserCategory = item;
    newUserCategory.is_favorite = value;
    final changed = await _userCategoriesRequest.change(newUserCategory);
    if (changed?.id == null) return;
    final newCategories = [...currentState.userCategories];
    final index =
        newCategories.indexWhere((user) => user?.id == newUserCategory.id);
    newCategories.replaceRange(index, index + 1, [changed]);
    setState(currentState.copyWith(userCategories: newCategories));
  }
}

class ScreenState {
  final bool loading;
  final List<UserCategoryModel?> userCategories;
  final List<String>? titles;

  ScreenState(
      {this.loading = false,
      this.userCategories = const [],
      this.titles = const []});

  ScreenState copyWith(
      {bool? loading,
      List<UserCategoryModel?>? userCategories,
      List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        userCategories: userCategories ?? this.userCategories,
        titles: titles ?? this.titles);
  }
}
