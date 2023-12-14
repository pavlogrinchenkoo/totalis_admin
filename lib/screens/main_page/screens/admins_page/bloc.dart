import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/admin/dto.dart';
import 'package:totalis_admin/api/admin/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/widgets/chage_page.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

class AdminsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final AdminRequest _adminRequest = AdminRequest();
  final GoogleSignIn? googleSignIn = GoogleSignIn();

  AdminsBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    setState(ScreenState(loading: true));
    final users = await _adminRequest.getAdmins();
    setState(currentState.copyWith(loading: false, admins: users ?? []));
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
        onSave: () => {onSave(context, fields, item, isCreate: item?.id == null)}));
  }

  onSave(BuildContext context, List<FieldModel> fields, AdminModel? item,
      {bool isCreate = false}) async {
    final newModel = AdminModel(
        firebase_uid: fields.firstWhere((i) => i.title == 'Firebase uid').controller?.text,
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
}

class ScreenState {
  final bool loading;
  final List<AdminModel?> admins;

  ScreenState({this.loading = false, this.admins = const []});

  ScreenState copyWith({bool? loading, List<AdminModel?>? admins}) {
    return ScreenState(
        loading: loading ?? this.loading, admins: admins ?? this.admins);
  }
}
