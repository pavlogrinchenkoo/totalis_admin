import 'package:flutter/material.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/api/categories/request.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
import 'package:totalis_admin/api/prompt/request.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user/bloc.dart';
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
  final TextEditingController recommendationController =
      TextEditingController();
  final TextEditingController controllerLlm = TextEditingController();
  final TextEditingController controllerMessage = TextEditingController();

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

  preview(BuildContext context, UserSearchBloc userBloc, int? categoryId,
      FieldModel? field) async {
    setState(currentState.copyWith(loadingPreview: true));
    if (userBloc.currentState.selectedUser?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: BC.green,
          content: const Text('Please select a user, category and message.'),
          duration: const Duration(seconds: 2)));
      setState(currentState.copyWith(loadingPreview: false));
    }
    if (field?.title == 'Prompt') {
      final string = await _promptRequest.promptCategory(
          field?.controller?.text,
          userBloc.currentState.selectedUser?.id,
          categoryId);
      controller.text = string ?? '';
    } else if (field?.title == 'Prompt checkin') {
      final string = await _promptRequest.promptCheckinCategory(
          field?.controller?.text,
          userBloc.currentState.selectedUser?.id,
          categoryId);
      controller.text = string ?? '';
    } else if (field?.title == 'Prompt checkin proposal') {
      final string = await _promptRequest.promptCheckinProposalCategory(
          field?.controller?.text,
          userBloc.currentState.selectedUser?.id,
          categoryId);
      controller.text = string ?? '';
    } else if (field?.title == 'Prompt how') {
      final string = await _promptRequest.promptHow(
          field?.controller?.text,
          userBloc.currentState.selectedUser?.id,
          categoryId,
          recommendationController.text);
      controller.text = string ?? '';
    } else if (field?.title == 'Prompt why') {
      final string = await _promptRequest.promptWhy(
          field?.controller?.text,
          userBloc.currentState.selectedUser?.id,
          categoryId,
          recommendationController.text);
      controller.text = string ?? '';
    }
    setState(currentState.copyWith(loadingPreview: false));

    // if (field?.title == 'Prompt') {
    //   if (userBloc.currentState.selectedUser?.id == null ||
    //       userCategoryBloc.currentState.selectedItem?.id == null) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         backgroundColor: BC.green,
    //         content: const Text('Please select a user, category and message.'),
    //         duration: const Duration(seconds: 2)));
    //     setState(currentState.copyWith(loadingPreview: false));
    //   }
    //   final string = await _promptRequest.promptCategory(
    //       field?.controller?.text ?? null,
    //       userBloc.currentState.selectedUser?.id,
    //       userCategoryBloc.currentState.selectedItem?.id,
    //       608);
    //   controller.text = string ?? '';
    // } else if (field?.title == 'Prompt checkin') {
    //   if (userBloc.currentState.selectedUser?.id == null ||
    //       checkinsBloc.currentState.selectedItem?.id == null) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         backgroundColor: BC.green,
    //         content: const Text('Please select a user, checkin and message.'),
    //         duration: const Duration(seconds: 2)));
    //     setState(currentState.copyWith(loadingPreview: false));
    //   }
    //   final string = await _promptRequest.promptCheckinCategory(
    //       field?.controller?.text ?? null,
    //       userBloc.currentState.selectedUser?.id,
    //       checkinsBloc.currentState.selectedItem?.id,
    //       608);
    //   controller.text = string ?? '';
    // } else if (field?.title == 'Prompt checkin proposal') {
    //   if (userBloc.currentState.selectedUser?.id == null ||
    //       userCategoryBloc.currentState.selectedItem?.id == null) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         backgroundColor: BC.green,
    //         content: const Text('Please select a user and category'),
    //         duration: const Duration(seconds: 2)));
    //     setState(currentState.copyWith(loadingPreview: false));
    //   }
    //   final string = await _promptRequest.promptCheckinProposalCategory(
    //       field?.controller?.text ?? null,
    //       userBloc.currentState.selectedUser?.id,
    //       userCategoryBloc.currentState.selectedItem?.id);
    //   controller.text = string ?? '';
    // }
    // setState(currentState.copyWith(loadingPreview: false));
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

  previewLlm(BuildContext context, String text) async {
    setState(currentState.copyWith(loadingLlm: true));
    if (controller.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: BC.green,
          content: const Text('Please select a user and category'),
          duration: const Duration(seconds: 2)));
    }
    final res = await _promptRequest.promptLLM(
      text,
      controllerMessage.text,
    );
    controllerLlm.text = res ?? '';
    setState(currentState.copyWith(loadingLlm: false));
  }

  onSave() {
    setState(currentState.copyWith(saved: true));
    Future.delayed(const Duration(seconds: 2), () {
      setState(currentState.copyWith(saved: false));
    });
  }
}

class ScreenState {
  final bool loading;
  final bool loadingPreview;
  final bool loadingLlm;
  final List<UserModel?> users;
  final List<Filters?>? userFilters;
  final List<CategoryModel?> categories;
  final List<String>? titles;
  final bool isAll;
  final int page;
  final UserModel? selectedUser;
  final CategoryModel? selectedCategory;
  final bool saved;

  ScreenState(
      {this.loading = false,
      this.loadingPreview = false,
      this.loadingLlm = false,
      this.users = const [],
      this.userFilters,
      this.categories = const [],
      this.titles = const [],
      this.isAll = false,
      this.page = 0,
      this.selectedUser,
      this.selectedCategory,
      this.saved = false});

  ScreenState copyWith(
      {bool? loading,
      bool? loadingPreview,
      bool? loadingLlm,
      List<UserModel?>? users,
      List<Filters?>? userFilters,
      List<CategoryModel?>? categories,
      List<String>? titles,
      bool? isAll,
      int? page,
      UserModel? selectedUser,
      CategoryModel? selectedCategory,
      bool? saved}) {
    return ScreenState(
        loading: loading ?? this.loading,
        loadingPreview: loadingPreview ?? this.loadingPreview,
        loadingLlm: loadingLlm ?? this.loadingLlm,
        users: users ?? this.users,
        userFilters: userFilters ?? this.userFilters,
        categories: categories ?? this.categories,
        titles: titles ?? this.titles,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        selectedUser: selectedUser ?? this.selectedUser,
        saved: saved ?? this.saved);
  }
}
