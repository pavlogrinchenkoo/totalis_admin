import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:totalis_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:totalis_admin/api/filters/dto.dart';
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
  List<DropdownMenuItem<String>> fields =
      ['id', 'user_category_id', 'text'].map((e) {
    return DropdownMenuItem(
        value: e, child: Text(e.toString().split('.').last));
  }).toList();
  String? field;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();

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
              child: ListView(
                controller: _scrollController,
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      CustomSheetHeaderWidget(
                          title: 'Messages',
                          onSave: () =>
                              _bloc.openChange(context, MessageModel())),
                      Space.w20,
                      Expanded(
                        flex: 1,
                        child: FormBuilderDropdown(
                            name: 'Select field',
                            decoration: const InputDecoration(
                              labelText: 'Select field',
                              border: OutlineInputBorder(),
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                            ),
                            focusColor: Colors.transparent,
                            initialValue: fields.first.value,
                            onChanged: (String? value) => setState(() {
                                  field = value;
                                }),
                            items: fields),
                      ),
                      Space.w16,
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          onChanged: (value) =>
                              value == '' ? _bloc.onSearch(null) : null,
                          controller: controller,
                          name: 'Message search',
                          decoration: const InputDecoration(
                            labelText: 'Message search',
                            hintText: 'Message search',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      Space.w16,
                      ElevatedButton(
                          style: themeData
                              .extension<AppButtonTheme>()!
                              .primaryElevated,
                          onPressed: () => controller.text != ''
                              ? _bloc.onSearch(
                                  Filters(
                                      field:
                                          field ?? fields.first.value ?? 'id',
                                      value: controller.text),
                                )
                              : null,
                          child: const Text('Search')),
                    ],
                  ),
                  Space.h24,
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
                                onTap: () => _bloc.openChange(context, item),
                                child: Row(
                                  children: [
                                    Expanded(child: SheetText(text: item?.id)),
                                    Space.w16,
                                    const CustomOpenIcon()
                                  ],
                                ))),
                            DataCell(UserCategoryDataCellWidget(
                                userCategoryId: item?.user_category_id)),
                            DataCell(CheckInDataCellWidget(
                                checkInId: item?.checkin_id)),
                            DataCell(
                                SheetText(text: _getStringRole(item?.role))),
                            DataCell(SheetText(text: item?.text)),
                            DataCell(SheetText(text: item?.tokens_used)),
                            DataCell(SheetText(text: item?.gpt_version)),
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

  _getStringRole(RoleEnum? role) {
    switch (role) {
      case RoleEnum.User:
        return 'User';
      case RoleEnum.Assistant:
        return 'Assistant';
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
