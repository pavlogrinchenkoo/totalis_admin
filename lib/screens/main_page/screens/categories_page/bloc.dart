import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/api/categories/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

class CategoriesBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final CategoriesRequest _categoriesRequest = CategoriesRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  CategoriesBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final categories = await _categoriesRequest.getAll();
    setState(
        currentState.copyWith(loading: false, categories: categories ?? []));
  }

  changeIsHome(CategoryModel? item, bool value) async {
    if (item == null) return;
    final newCategory = item;
    newCategory.is_home = value;
    final changed = await _categoriesRequest.change(newCategory);
    if (changed?.id == null) return;
    final categories = [...currentState.categories];
    final index = categories.indexWhere((user) => user?.id == newCategory.id);
    categories.replaceRange(index, index + 1, [changed]);
    setState(currentState.copyWith(categories: categories));
  }
}

class ScreenState {
  final bool loading;
  final List<CategoryModel?> categories;
  final List<String>? titles;

  ScreenState(
      {this.loading = false,
      this.categories = const [],
      this.titles = const []});

  ScreenState copyWith(
      {bool? loading, List<CategoryModel?>? categories, List<String>? titles}) {
    return ScreenState(
        loading: loading ?? this.loading,
        categories: categories ?? this.categories,
        titles: titles ?? this.titles);
  }
}
