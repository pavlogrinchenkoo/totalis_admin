import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/admin/dto.dart';
import 'package:totalis_admin/api/admin/request.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/filters/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';
import 'package:totalis_admin/widgets/chage_page.dart';

class AdminsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final AdminRequest _adminRequest = AdminRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();
  final FilterRequest _filterRequest = FilterRequest();

  AdminsBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    await uploadItems();
    setState(currentState.copyWith(loading: false));
  }

  changeAdminEnabled(AdminModel? item, bool enabled) async {
    if (item == null) return;
    final newAdmin = item;
    newAdmin.enabled = enabled;
    final changed = await _adminRequest.change(newAdmin);
    if (changed?.id == null) return;
    final admins = [...currentState.admins];
    final index = admins.indexWhere((admin) => admin?.id == newAdmin.id);
    admins.replaceRange(index, index + 1, [changed]);
    setState(currentState.copyWith(admins: admins));
  }

  changeAdminSuperAdmin(AdminModel? item, bool enabled) async {
    if (item == null) return;
    final newAdmin = item;
    newAdmin.super_admin = enabled;
    final changed = await _adminRequest.change(newAdmin);
    replaceItem(changed, newAdmin);
  }

  openChange(BuildContext context, AdminModel? item) {
    final fields = [
      FieldModel(
          title: 'Name', controller: TextEditingController(text: item?.name)),
      FieldModel(
          title: 'Email',
          type: FieldType.email,
          controller: TextEditingController(text: item?.mail)),
      FieldModel(
          title: 'Enabled', type: FieldType.checkbox, value: item?.enabled),
      FieldModel(
          title: 'Super admin',
          type: FieldType.checkbox,
          value: item?.super_admin),
      FieldModel(
          title: 'Firebase uid',
          required: true,
          type: FieldType.text,
          controller: TextEditingController(text: item?.firebase_uid)),
    ];
    context.router.push(ChangeRoute(
        fields: fields,
        title: 'Admin',
        onSave: () =>
            {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, AdminModel? item,
      {bool isCreate = false}) async {
    final newModel = AdminModel(
        firebase_uid: fields
            .firstWhere((i) => i.title == 'Firebase uid')
            .controller
            ?.text,
        id: item?.id,
        time_create: item?.time_create,
        name: fields.firstWhere((i) => i.title == 'Name').controller?.text,
        mail: fields.firstWhere((i) => i.title == 'Email').controller?.text,
        enabled: fields.firstWhere((i) => i.title == 'Enabled').value,
        super_admin: fields.firstWhere((i) => i.title == 'Super admin').value);

    if (isCreate) {
      onCreate(context, newModel);
      return;
    }
    final res = await _adminRequest.change(newModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  Future<void> onCreate(BuildContext context, AdminModel newModel) async {
    final requestModel = AdminRequestModel(
      name: newModel.name,
      mail: newModel.mail,
      enabled: newModel.enabled,
      super_admin: newModel.super_admin,
      firebase_uid: newModel.firebase_uid,
    );

    final res = await _adminRequest.create(requestModel);
    replaceItem(res, newModel);
    if (context.mounted) context.router.pop();
  }

  void replaceItem(AdminModel? changed, AdminModel? newAdmin) {
    if (changed?.id == null) return;
    final admins = [...currentState.admins];
    final index = admins.indexWhere((admin) => admin?.id == newAdmin?.id);
    admins.replaceRange(index, index + 1, [changed]);
    setState(currentState.copyWith(admins: admins));
  }

  Future<void> uploadItems(
      {int? page, bool? isAll, List<Filters?>? filters}) async {
    if ((currentState.isAll && filters == null) || currentState.loadingMore) {
      return;
    }
    setState(currentState.copyWith(loadingMore: true));
    final items = await _filterRequest.adminsFilters(QueryModel(
        page: page ?? currentState.page,
        count: 20,
        filters: filters ?? currentState.filters,
        orders: []));
    if (items != null) {
      final List<AdminModel?> newItems =
          page == 0 ? [...items] : [...currentState.admins, ...items];
      final newIsAll = (items.length) < 20;
      setState(currentState.copyWith(
          admins: newItems,
          filters: filters ?? currentState.filters,
          page: (page ?? currentState.page) + 1,
          isAll: newIsAll));
    } else {
      setState(currentState.copyWith(isAll: true));
    }
    setState(currentState.copyWith(loadingMore: false));
  }
}

class ScreenState {
  final bool loading;
  final bool loadingMore;
  final List<AdminModel?> admins;
  final List<Filters?>? filters;
  final bool isAll;
  final int page;

  ScreenState(
      {this.loading = false,
      this.loadingMore = false,
      this.admins = const [],
      this.filters = const [],
      this.isAll = false,
      this.page = 0});

  ScreenState copyWith(
      {bool? loading,
      bool? loadingMore,
      List<AdminModel?>? admins,
      List<Filters?>? filters,
      bool? isAll,
      int? page}) {
    return ScreenState(
        loading: loading ?? this.loading,
        loadingMore: loadingMore ?? this.loadingMore,
        admins: admins ?? this.admins,
        filters: filters ?? this.filters,
        isAll: isAll ?? this.isAll,
        page: page ?? this.page);
  }
}
