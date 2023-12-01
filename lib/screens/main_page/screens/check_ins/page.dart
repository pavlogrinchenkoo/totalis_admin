import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/check_ins/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/user_categories_page/bloc.dart'
    as ub;
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/category_data_cell_widget.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

import 'bloc.dart';

@RoutePage()
class CheckInsPage extends StatefulWidget {
  const CheckInsPage({super.key});

  @override
  State<CheckInsPage> createState() => _CheckInsPageState();
}

class _CheckInsPageState extends State<CheckInsPage> {
  final CheckInsBloc _bloc = CheckInsBloc();
  final ub.UserCategoriesBloc _blocUserCategory = ub.UserCategoriesBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Id',
      'User category id',
      'Category id',
      'Level',
      'Date',
      'Summary',
    ];
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.checkins.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Check-ins',
                      onSave: () => _bloc.openChange(context, CheckInModel())),
                  Space.h24,
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CustomSheetWidget(
                          columns: <DataColumn>[
                            for (final title in titles)
                              DataColumn(
                                label: Expanded(
                                  child: Text(title),
                                ),
                              ),
                          ],
                          rows: <DataRow>[
                            for (final item in state.checkins)
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
                                          SheetText(text: item.id),
                                        ],
                                      ))),
                                  DataCell(InkWell(
                                      borderRadius: BRadius.r6,
                                      onTap: () async =>
                                          _blocUserCategory.openChange(
                                              context,
                                              await _blocUserCategory
                                                  .getUserCategory(
                                                      item.user_category_id)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SheetText(
                                              text: item.user_category_id),
                                        ],
                                      ))),
                                  DataCell(CategoryDataCellWidget(
                                      userCategoryId: item.user_category_id)),
                                  DataCell(SheetText(text: item.level)),
                                  DataCell(SheetText(text: item.date)),
                                  DataCell(SheetText(text: item.summary)),
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
}
