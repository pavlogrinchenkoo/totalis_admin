import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/coaches/dto.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_circle_avatar.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

import 'bloc.dart';

@RoutePage()
class CoachesPage extends StatefulWidget {
  const CoachesPage({super.key});

  @override
  State<CoachesPage> createState() => _CoachesPageState();
}

class _CoachesPageState extends State<CoachesPage> {
  final CoachesBloc _bloc = CoachesBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Id',
      'Name',
      'Prompt',
      'Description',
    ];

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.coaches.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Coaches',
                      onSave: () => _bloc.openChange(context, CoachesModel())),
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
                            for (final item in state.coaches)
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(InkWell(
                                      borderRadius: BRadius.r6,
                                      onTap: () =>
                                          _bloc.openChange(context, item),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              SheetText(text: item?.id),
                                            ],
                                          ),
                                        ],
                                      ))),
                                  DataCell(Row(
                                    children: [
                                      CustomCircle(imageId: item?.image_id),
                                      Space.w16,
                                      SheetText(text: item?.name),
                                    ],
                                  )),
                                  DataCell(SheetText(text: item?.prompt)),
                                  DataCell(SheetText(text: item?.description)),
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
