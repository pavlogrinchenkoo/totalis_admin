import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/admin/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/admins_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_checkbox.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

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
    final titles = ['Id', 'Users name', 'Email', 'Enabled', 'Super admin'];

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.admins.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Admins',
                      onSave: () => _bloc.openChange(context, AdminModel())),
                  Space.h24,
                  CustomSheetWidget(
                    columns: <DataColumn>[
                      for (final title in titles)
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              title,
                            ),
                          ),
                        ),
                    ],
                    rows: <DataRow>[
                      for (final AdminModel? item in state.admins)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(InkWell(
                                borderRadius: BRadius.r6,
                                onTap: () => _bloc.openChange(context, item),
                                child: Row(
                                  children: [
                                    SheetText(text: item?.id),
                                    Space.w8,
                                    const CustomOpenIcon()
                                  ],
                                ))),
                            DataCell(SheetText(text: item?.name)),
                            DataCell(SheetText(text: item?.mail)),
                            DataCell(CustomCheckbox(
                                value: item?.enabled,
                                onChanged: (enabled) =>
                                    _bloc.changeAdminEnabled(item, enabled))),
                            DataCell(CustomCheckbox(
                                value: item?.super_admin,
                                onChanged: (enabled) => _bloc
                                    .changeAdminSuperAdmin(item, enabled))),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ));
          }
        });
  }
}
