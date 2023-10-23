import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/admin/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/admins_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';

import 'widgets/custom_sheets_widget.dart';

@RoutePage()
class AdminsPage extends StatefulWidget {
  const AdminsPage({super.key});

  @override
  State<AdminsPage> createState() => _AdminsPageState();
}

class _AdminsPageState extends State<AdminsPage> {
  final AdminsBloc _bloc = AdminsBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.admins.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.only(top: 80, left: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text('Admins', style: BS.sb32),
                    Space.w52,
                    // CustomButton(title: 'New Admin', onTap: () {}),
                  ]),
                  Space.h24,
                  CustomSheetsWidget(
                      onChangeEnabled: (AdminModel? item, bool enabled) =>
                          _bloc.changeAdminEnabled(item, enabled),
                      onChangeSuperAdmin: (AdminModel? item, bool enabled) =>
                          _bloc.changeAdminSuperAdmin(item, enabled),
                      items: state.admins,
                      openChange: (item) => _bloc.openChange(context, item))
                ],
              ),
            ));
          }
        });
  }
}
