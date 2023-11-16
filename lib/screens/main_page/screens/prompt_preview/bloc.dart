import 'package:flutter/material.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/api/categories/request.dart';
import 'package:totalis_admin/api/prompt/request.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/api/user/request.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class PromptPreviewBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final UserRequest _usersRequest = UserRequest();
  final CategoriesRequest _categoriesRequest = CategoriesRequest();
  final PromptRequest _promptRequest = PromptRequest();
  final TextEditingController controller = TextEditingController();

  PromptPreviewBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    await uploadUsers();
    final categories = await _categoriesRequest.getAll();
    setState(currentState.copyWith(loading: false, categories: categories));
  }

  Future<void> uploadUsers() async {
    final users = await _usersRequest.getAll(page: currentState.page);
    if (users != null) {
      final List<UserModel?> newUsers = [...currentState.users, ...users ?? []];
      final newIsAll = (users.length ?? 0) < 20;
      setState(currentState.copyWith(
          users: newUsers, page: currentState.page + 1, isAll: newIsAll));
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

  preview(FieldModel? field) async {
    if (field?.title == 'Prompt') {
      final string = await _promptRequest
          .promptCategory(currentState.selectedUser?.id ?? 0);
      controller.text = string ?? '';
    } else if (field?.title == 'Propmpt preview') {}
  }
}

class ScreenState {
  final bool loading;
  final List<UserModel?> users;
  final List<CategoryModel?> categories;
  final List<String>? titles;
  final bool isAll;
  final int page;
  final UserModel? selectedUser;
  final CategoryModel? selectedCategory;

  ScreenState(
      {this.loading = false,
      this.users = const [],
      this.categories = const [],
      this.titles = const [],
      this.isAll = false,
      this.page = 0,
      this.selectedUser,
      this.selectedCategory});

  ScreenState copyWith(
      {bool? loading,
      List<UserModel?>? users,
      List<CategoryModel?>? categories,
      List<String>? titles,
      bool? isAll,
      int? page,
      UserModel? selectedUser,
      CategoryModel? selectedCategory}) {
    return ScreenState(
        loading: loading ?? this.loading,
        users: users ?? this.users,
        categories: categories ?? this.categories,
        titles: titles ?? this.titles,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        selectedUser: selectedUser ?? this.selectedUser);
  }
}
