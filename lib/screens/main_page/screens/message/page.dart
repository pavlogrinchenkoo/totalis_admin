import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/messages/dto.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/check_in_data_cell_widget.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';
import 'package:totalis_admin/widgets/user_category_data_cell_widget.dart';

import 'bloc.dart';

@RoutePage()
class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final MessageBloc _bloc = MessageBloc();

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
      'Сheckin',
      'Role',
      'Text',
      'Token',
      'GPT version',
    ];

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.messages.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Messages',
                      onSave: () => _bloc.openChange(context, MessageModel())),
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
                            for (final item in state.messages)
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
                                  DataCell(UserCategoryDataCellWidget(
                                      userCategoryId: item?.user_category_id)),
                                  DataCell(CheckInDataCellWidget(
                                      checkInId: item?.checkin_id)),
                                  DataCell(SheetText(
                                      text: _getStringRole(item?.role))),
                                  DataCell(SheetText(text: item?.text)),
                                  DataCell(SheetText(text: item?.tokens_used)),
                                  DataCell(SheetText(text: item?.gpt_version)),
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

  _getStringRole(RoleEnum? role) {
    switch (role) {
      case RoleEnum.user:
        return 'User';
      case RoleEnum.assistant:
        return 'Assistant';
      default:
        return '';
    }
  }
}
