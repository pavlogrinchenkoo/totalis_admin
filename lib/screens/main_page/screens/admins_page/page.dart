import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/admin/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/admins_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_checkbox.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _bloc.init();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['Id', 'Name', 'Email', 'Enabled', 'Super admin'];

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.admins.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Admins',
                      onSave: () => _bloc.openChange(context, AdminModel())),
                  Space.h18,
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        Row(
                          children: [
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
                                          onTap: () =>
                                              _bloc.openChange(context, item),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SheetText(text: item?.id),
                                            ],
                                          ))),
                                      DataCell(SheetText(text: item?.name)),
                                      DataCell(SheetText(text: item?.mail)),
                                      DataCell(CustomCheckbox(
                                          value: item?.enabled,
                                          onChanged: (enabled) =>
                                              _bloc.changeAdminEnabled(
                                                  item, enabled))),
                                      DataCell(CustomCheckbox(
                                          value: item?.super_admin,
                                          onChanged: (enabled) =>
                                              _bloc.changeAdminSuperAdmin(
                                                  item, enabled))),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
          }
        });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      _bloc.uploadItems();
    }
  }
}
