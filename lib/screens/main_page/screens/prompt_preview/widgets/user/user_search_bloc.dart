import 'package:flutter/material.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/api/categories/request.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
import 'package:totalis_admin/api/prompt/request.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/api/user/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/utils/custom_function.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class UserSearchBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final UserRequest _usersRequest = UserRequest();
  final CategoriesRequest _categoriesRequest = CategoriesRequest();
  final PromptRequest _promptRequest = PromptRequest();
  final FilterRequest _filterRequest = FilterRequest();
  final TextEditingController controller = TextEditingController();

  UserSearchBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    await uploadUsers();
    final categories = await _categoriesRequest.getAll();
    setState(currentState.copyWith(loading: false, categories: categories));
  }

  Future<void> uploadUsers(
      {int? page, bool? isAll, List<Filters?>? filters}) async {
    final users = await _filterRequest.userFilters(QueryModel(
        page: page ?? currentState.page,
        count: 20,
        filters: filters ?? currentState.userFilters ?? []));
    if (users != null) {
      final List<UserModel?> newUsers =
          page == 0 ? [...users] : [...currentState.users, ...users];
      final newIsAll = (users.length) < 20;
      setState(currentState.copyWith(
          users: newUsers,
          page: (page ?? currentState.page) + 1,
          isAll: newIsAll));
    } else {
      setState(currentState.copyWith(isAll: true));
    }
  }

  selectUser(UserModel? user) {
    setState(currentState.copyWith(selectedUser: user));
  }

  selectCategory(CategoryModel? category) async {
    setState(currentState.copyWith(selectedCategory: category));
  }

  searchUser(Filters? filters) async {
    if (filters == null) {
      setState(currentState..copyWith(userFilters: [], page: 0, isAll: false));
      uploadUsers(page: 0, isAll: false, filters: []);
      return null;
    }
    final newFilters =
        containsInt(filters.field) || containsLevel(filters.value)
            ? Filters(field: filters.field, value: int.tryParse(filters.value))
            : filters;
    setState(currentState
      ..copyWith(userFilters: [newFilters], page: 0, isAll: false));
    uploadUsers(page: 0, isAll: false, filters: [newFilters]);
  }
}

class ScreenState {
  final bool loading;
  final List<UserModel?> users;
  final List<Filters?>? userFilters;
  final List<CategoryModel?> categories;
  final List<String>? titles;
  final bool isAll;
  final int page;
  final UserModel? selectedUser;
  final CategoryModel? selectedCategory;

  ScreenState(
      {this.loading = false,
      this.users = const [],
      this.userFilters,
      this.categories = const [],
      this.titles = const [],
      this.isAll = false,
      this.page = 0,
      this.selectedUser,
      this.selectedCategory});

  ScreenState copyWith(
      {bool? loading,
      List<UserModel?>? users,
      List<Filters?>? userFilters,
      List<CategoryModel?>? categories,
      List<String>? titles,
      bool? isAll,
      int? page,
      UserModel? selectedUser,
      CategoryModel? selectedCategory}) {
    return ScreenState(
        loading: loading ?? this.loading,
        users: users ?? this.users,
        userFilters: userFilters ?? this.userFilters,
        categories: categories ?? this.categories,
        titles: titles ?? this.titles,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        selectedUser: selectedUser ?? this.selectedUser);
  }
}
