import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/messages/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user/bloc.dart'
    as ub;
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user/widget.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user_category/bloc.dart'
    as ucb;
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user_category/widget.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/check_in_data_cell_widget.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

import 'bloc.dart';
import 'user_and_category/page.dart';

@RoutePage()
class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final MessageBloc _bloc = MessageBloc();
  final ub.UserSearchBloc userBloc = ub.UserSearchBloc();
  final ucb.UserCategorySearchBloc userCategoryBloc =
      ucb.UserCategorySearchBloc();

  List<DropdownMenuItem<String>> fields =
      ['id', 'user_category_id', 'User and category', 'text'].map((e) {
    return DropdownMenuItem(
        value: e, child: Text(e.toString().split('.').last));
  }).toList();
  String? field;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  late ScreenState lastState;

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
    final themeData = Theme.of(context);
    final titles = [
      'Id',
      'UC ID',
      'User and category',
      'Сheckin',
      'Role',
      'Token',
      'Text',
    ];

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.messages.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                children: [
                  Space.h8,
                  Row(
                    children: [
                      CustomSheetHeaderWidget(
                          title: 'Messages',
                          onSave: () =>
                              _bloc.openChange(context, MessageModel())),
                      Space.w20,
                      UserSearchWidget(bloc: userBloc),
                      Space.w20,
                      UserCategorySearchWidget(
                          bloc: userCategoryBloc,
                          userBloc: userBloc,
                          onChange: () => _bloc.onSearch(Filters(
                              field: 'user_category_id',
                              value: userCategoryBloc
                                  .currentState.selectedItem?.id)),
                          onClear: () => _bloc.onSearch(null)),
                    ],
                  ),
                  Space.h18,
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      children: [
                        CustomSheetWidget(
                          columns: <DataColumn>[
                            for (final title in titles)
                              DataColumn(
                                label: Expanded(child: Text(title)),
                              ),
                          ],
                          rows: <DataRow>[
                            for (final item in state.messages)
                              DataRow(
                                onSelectChanged: (bool? selected) =>
                                    _bloc.openChange(context, item),
                                cells: <DataCell>[
                                  DataCell(SheetText(text: item?.id)),
                                  DataCell(
                                      Padding(
                                        padding: const EdgeInsets.only(right: 16),
                                        child: SheetText(text: item?.user_category_id),
                                      )),
                                  DataCell(UserAndCategoryWidget(
                                      userCategoryId: item?.user_category_id)),
                                  DataCell(CheckInDataCellWidget(
                                      checkInId: item?.checkin_id)),
                                  DataCell(SheetText(
                                      text: _getStringRole(item?.role))),
                                  DataCell(SheetText(text: item?.tokens_used)),
                                  DataCell(Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              (item?.text ?? "").toString()),
                                        ),
                                      ],
                                    ),
                                  )),
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
      case RoleEnum.User:
        return 'User';
      case RoleEnum.Assistant:
        return 'Assistant';
      case RoleEnum.PreAssistant:
        return 'PreAssistant';
      case RoleEnum.System:
        return 'System';
      default:
        return '';
    }
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      _bloc.uploadItems();
    }
  }
}
