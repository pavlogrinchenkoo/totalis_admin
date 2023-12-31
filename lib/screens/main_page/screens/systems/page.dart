import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/system/dto.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

import 'bloc.dart';

@RoutePage()
class SystemPage extends StatefulWidget {
  const SystemPage({super.key});

  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  final SystemBloc _bloc = SystemBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Field',
      'Value',
    ];
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.system != null) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Systems',
                      onSave: () => _bloc.openChange(context, state.system),
                      customText: 'Change'),
                  Space.h18,
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
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
                                for (final item
                                    in (state.system ?? SystemModel())
                                        .toJson()
                                        .keys)
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(SheetText(text: item)),
                                      DataCell(SheetText(
                                          text: state.system?.toJson()[item])),
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
}
