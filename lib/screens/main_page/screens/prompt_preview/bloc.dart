import 'package:flutter/material.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/api/categories/request.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
import 'package:totalis_admin/api/prompt/request.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/api/user/request.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/page.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/checkins/bloc.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/message/bloc.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user/user_search_bloc.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user_category/user_category_search_bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class PromptPreviewBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final CategoriesRequest _categoriesRequest = CategoriesRequest();
  final PromptRequest _promptRequest = PromptRequest();
  final FilterRequest _filterRequest = FilterRequest();
  final TextEditingController controller = TextEditingController();
  final TextEditingController controllerLlm = TextEditingController();

  PromptPreviewBloc() {
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

  preview(
      BuildContext context,
      FieldModel? field,
      UserCategorySearchBloc userCategoryBloc,
      MessagesSearchBloc messagesBloc,
      CheckinsSearchBloc checkinsBloc,
      UserSearchBloc userBloc) async {
    if (field?.title == 'Prompt') {
      if (userBloc.currentState.selectedUser?.id == null ||
          userCategoryBloc.currentState.selectedItem?.id == null ||
          messagesBloc.currentState.selectedItem?.id == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: BC.green,
            content: const Text('Please select a user, category and message.'),
            duration: const Duration(seconds: 2)));
      }
      final string = await _promptRequest.promptCategory(
          field?.controller?.text ?? null,
          userBloc.currentState.selectedUser?.id,
          userCategoryBloc.currentState.selectedItem?.id,
          messagesBloc.currentState.selectedItem?.id);
      controller.text = string ?? '';
    } else if (field?.title == 'Prompt checkin') {
      if (userBloc.currentState.selectedUser?.id == null ||
          checkinsBloc.currentState.selectedItem?.id == null ||
          messagesBloc.currentState.selectedItem?.id == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: BC.green,
            content: const Text('Please select a user, checkin and message.'),
            duration: const Duration(seconds: 2)));
      }
      final string = await _promptRequest.promptCheckinCategory(
          field?.controller?.text ?? null,
          userBloc.currentState.selectedUser?.id,
          checkinsBloc.currentState.selectedItem?.id,
          messagesBloc.currentState.selectedItem?.id);
      controller.text = string ?? '';
    } else if (field?.title == 'Prompt checkin proposal') {
      if (userBloc.currentState.selectedUser?.id == null ||
          userCategoryBloc.currentState.selectedItem?.id == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: BC.green,
            content: const Text('Please select a user and category'),
            duration: const Duration(seconds: 2)));
      }
      final string = await _promptRequest.promptCheckinProposalCategory(
          field?.controller?.text ?? null,
          userBloc.currentState.selectedUser?.id,
          userCategoryBloc.currentState.selectedItem?.id);
      controller.text = string ?? '';
    }
  }

  searchUser(Filters? filters) async {
    if (filters == null) {
      setState(currentState..copyWith(userFilters: [], page: 0, isAll: false));
      uploadUsers(page: 0, isAll: false, filters: []);
      return null;
    }

    setState(
        currentState..copyWith(userFilters: [filters], page: 0, isAll: false));
    uploadUsers(page: 0, isAll: false, filters: [filters]);
  }

  previewLlc(BuildContext context, String text) async {
    if (controller.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: BC.green,
          content: const Text('Please select a user and category'),
          duration: const Duration(seconds: 2)));
    }
    final res = await _promptRequest.promptLLM(text);
    controllerLlm.text = res ?? '';
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
