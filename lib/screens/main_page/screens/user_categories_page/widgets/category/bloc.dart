import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/api/categories/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

class CategoryWidgetBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final CategoriesRequest _request = CategoriesRequest();

  CategoryWidgetBloc() {
    setState(ScreenState());
  }

  Future<void> init(int? id) async {
    setState(currentState.copyWith(loading: true));
    final res = await _request.get(id);
    setState(currentState.copyWith(loading: false, category: res));
  }
}

class ScreenState {
  final bool loading;
  final CategoryModel? category;

  ScreenState({this.loading = false, this.category});

  ScreenState copyWith({bool? loading, CategoryModel? category}) {
    return ScreenState(
        loading: loading ?? this.loading, category: category ?? this.category);
  }
}
