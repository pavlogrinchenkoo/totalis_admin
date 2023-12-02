import 'package:flutter/material.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/api/categories/request.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
import 'package:collection/collection.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

class UserCategorySearchBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final FilterRequest _filterRequest = FilterRequest();
  final CategoriesRequest _categoriesRequest = CategoriesRequest();
  final TextEditingController controller = TextEditingController();

  UserCategorySearchBloc() {
    setState(ScreenState());
  }

  //
  // Future<void> init() async {
  //   setState(ScreenState(loading: true));
  //   await uploadItems();
  //   setState(currentState.copyWith(loading: false));
  // }
  //
  // Future<void> uploadItems(
  //     {int? page, bool? isAll, List<Filters?>? filters}) async {
  //   if (currentState.isAll && filters == null) return;
  //   final items = await _filterRequest.userCategoryFilters(QueryModel(
  //       page: page ?? currentState.page,
  //       count: 20,
  //       filters: filters ?? currentState.filters ?? []));
  //   if (items != null) {
  //     final List<UserCategoryModel?> newItems =
  //         page == 0 ? [...items] : [...currentState.items, ...items];
  //     final newIsAll = (items.length) < 20;
  //     setState(currentState.copyWith(
  //         items: newItems,
  //         page: (page ?? currentState.page) + 1,
  //         isAll: newIsAll));
  //   } else {
  //     setState(currentState.copyWith(isAll: true));
  //   }
  // }
  //
  // selectUser(UserCategoryModel? user) {
  //   setState(currentState.copyWith(selectedItem: user));
  // }
  //
  // searchUser(Filters? filters) async {
  //   if (filters == null) {
  //     setState(currentState..copyWith(filters: [], page: 0, isAll: false));
  //     uploadItems(page: 0, isAll: false, filters: []);
  //     return null;
  //   }
  //
  //   final newFilters =
  //       containsInt(filters.field) || containsLevel(filters.value)
  //           ? Filters(field: filters.field, value: int.tryParse(filters.value))
  //           : filters;
  //   setState(
  //       currentState..copyWith(filters: [newFilters], page: 0, isAll: false));
  //   uploadItems(page: 0, isAll: false, filters: [newFilters]);
  // }

  Future<void> setUser(UserModel? selectedUser,
      {void Function()? onClear}) async {
    if (selectedUser == null || selectedUser.id == null) {
      setState(currentState.copyWith(
          selectedUser: UserModel(), userCategories: [], categories: []));
      if (onClear != null) {
        onClear.call();
      }
    } else {
      final userCategories = await _filterRequest.userCategoryFilters(
          QueryModel(
              page: 0,
              count: 20,
              filters: [Filters(field: 'user_id', value: selectedUser.id)]));
      userCategories?.removeWhere((uc) => uc.user_id != selectedUser.id);
      final categories = <CategoryModel>[];
      for (final UserCategoryModel uc in userCategories ?? []) {
        final category = await _categoriesRequest.get(uc.category_id);
        if (category != null) {
          categories.add(category);
        }
      }
      setState(currentState.copyWith(
          selectedUser: selectedUser,
          selectedItem: userCategories?.first,
          userCategories: userCategories,
          categories: categories));
    }
  }

  setCategory(CategoryModel? value, List<UserCategoryModel?> userCategories) {
    final userCategory =
        userCategories.firstWhereOrNull((uc) => uc?.category_id == value?.id);
    if (userCategory != null) {
      setState(currentState.copyWith(selectedItem: userCategory));
    }
  }
}

class ScreenState {
  final bool loading;
  final List<UserCategoryModel?> items;
  final List<UserCategoryModel?> userCategories;
  final List<CategoryModel?> categories;
  final List<Filters?>? filters;
  final bool isAll;
  final int page;
  final UserModel? selectedUser;
  final UserCategoryModel? selectedItem;

  ScreenState(
      {this.loading = false,
      this.items = const [],
      this.userCategories = const [],
      this.categories = const [],
      this.filters,
      this.isAll = false,
      this.page = 0,
      this.selectedUser,
      this.selectedItem});

  ScreenState copyWith(
      {bool? loading,
      List<UserCategoryModel?>? items,
      List<UserCategoryModel?>? userCategories,
      List<CategoryModel?>? categories,
      List<Filters?>? filters,
      bool? isAll,
      int? page,
      UserModel? selectedUser,
      UserCategoryModel? selectedItem}) {
    return ScreenState(
        loading: loading ?? this.loading,
        items: items ?? this.items,
        userCategories: userCategories ?? this.userCategories,
        categories: categories ?? this.categories,
        filters: filters ?? this.filters,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page,
        selectedUser: selectedUser ?? this.selectedUser,
        selectedItem: selectedItem ?? this.selectedItem);
  }
}
