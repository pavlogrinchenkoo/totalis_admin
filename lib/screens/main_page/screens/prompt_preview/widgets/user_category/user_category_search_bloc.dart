import 'package:flutter/material.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/utils/custom_function.dart';

class UserCategorySearchBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final FilterRequest _filterRequest = FilterRequest();
  final TextEditingController controller = TextEditingController();

  UserCategorySearchBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    await uploadItems();
    setState(currentState.copyWith(loading: false));
  }

  Future<void> uploadItems(
      {int? page, bool? isAll, List<Filters?>? filters}) async {
    if (currentState.isAll && filters == null) return;
    final items = await _filterRequest.userCategoryFilters(QueryModel(
        page: page ?? currentState.page,
        count: 20,
        filters: filters ?? currentState.filters ?? []));
    if (items != null) {
      final List<UserCategoryModel?> newItems =
          page == 0 ? [...items] : [...currentState.items, ...items];
      final newIsAll = (items.length) < 20;
      setState(currentState.copyWith(
          items: newItems,
          page: (page ?? currentState.page) + 1,
          isAll: newIsAll));
    } else {
      setState(currentState.copyWith(isAll: true));
    }
  }

  selectUser(UserCategoryModel? user) {
    setState(currentState.copyWith(selectedItem: user));
  }

  searchUser(Filters? filters) async {
    if (filters == null) {
      setState(currentState..copyWith(filters: [], page: 0, isAll: false));
      uploadItems(page: 0, isAll: false, filters: []);
      return null;
    }

    final newFilters =
        containsInt(filters.field) || containsLevel(filters.value)
            ? Filters(field: filters.field, value: int.tryParse(filters.value))
            : filters;
    setState(
        currentState..copyWith(filters: [newFilters], page: 0, isAll: false));
    uploadItems(page: 0, isAll: false, filters: [newFilters]);
  }
}

class ScreenState {
  final bool loading;
  final List<UserCategoryModel?> items;
  final List<Filters?>? filters;
  final bool isAll;
  final int page;
  final UserCategoryModel? selectedItem;

  ScreenState(
      {this.loading = false,
      this.items = const [],
      this.filters,
      this.isAll = false,
      this.page = 0,
      this.selectedItem});

  ScreenState copyWith(
      {bool? loading,
      List<UserCategoryModel?>? items,
      List<Filters?>? filters,
      bool? isAll,
      int? page,
      UserCategoryModel? selectedItem}) {
    return ScreenState(
        loading: loading ?? this.loading,
        items: items ?? this.items,
        filters: filters ?? this.filters,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page,
        selectedItem: selectedItem ?? this.selectedItem);
  }
}
