import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/recommendation/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/check_ins/bloc.dart'
    as cb;
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/category_data_cell_widget.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';
import 'package:totalis_admin/widgets/user_category_data_cell_widget.dart';

import 'bloc.dart';

@RoutePage()
class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  final RecommendationBloc _bloc = RecommendationBloc();
  final cb.CheckInsBloc _blocCheckIns = cb.CheckInsBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Id',
      'Check-in id',
      'User Category id',
      'Category id',
      'Text',
    ];

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.recommendations.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Recommendations',
                      onSave: () =>
                          _bloc.openChange(context, RecommendationModel())),
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
                            for (final item in state.recommendations)
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(InkWell(
                                      borderRadius: BRadius.r6,
                                      onTap: () =>
                                          _bloc.openChange(context, item),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: SheetText(text: item?.id)),
                                          Space.w16,
                                          const CustomOpenIcon()
                                        ],
                                      ))),
                                  DataCell(InkWell(
                                      borderRadius: BRadius.r6,
                                      onTap: () async =>
                                          _blocCheckIns.openChange(
                                              context,
                                              await _blocCheckIns.getCheckIn(
                                                  item?.checkin_id)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: SheetText(
                                                  text: item?.checkin_id)),
                                          Space.w16,
                                          const CustomOpenIcon()
                                        ],
                                      ))),
                                  for (final w in _userCategoryAndCategory(
                                      item?.checkin_id))
                                    DataCell(w),
                                  DataCell(SheetText(text: item?.text)),
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

  _userCategoryAndCategory(int? id) {
    final checkIn = _blocCheckIns.getCheckIn(id);
    return [
      UserCategoryDataCellWidget(checkIn: checkIn,),
      CategoryDataCellWidget(
        checkIn: checkIn,
      )
    ];
  }
}
