import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/messages/dto.dart';
import 'package:totalis_admin/api/models_chat_gpt/dto.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

import 'bloc.dart';

@RoutePage()
class ModelsChatGptPage extends StatefulWidget {
  const ModelsChatGptPage({super.key});

  @override
  State<ModelsChatGptPage> createState() => _ModelsChatGptPageState();
}

class _ModelsChatGptPageState extends State<ModelsChatGptPage> {
  final ModelsChatGptBloc _bloc = ModelsChatGptBloc();
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
    final titles = [
      'Id',
      'Model',
    ];

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: ListView(
                controller: _scrollController,
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      CustomSheetHeaderWidget(
                          title: 'Model chat gpt',
                          onSave: () =>
                              _bloc.openChange(context, ModelsChatGptModel())),
                      Space.w20,
                      //   Expanded(
                      //     flex: 1,
                      //     child: FormBuilderDropdown(
                      //         name: 'Select field',
                      //         decoration: const InputDecoration(
                      //           labelText: 'Select field',
                      //           border: OutlineInputBorder(),
                      //           hoverColor: Colors.transparent,
                      //           focusColor: Colors.transparent,
                      //         ),
                      //         focusColor: Colors.transparent,
                      //         initialValue: fields.first.value,
                      //         onChanged: (String? value) => setState(() {
                      //               field = value;
                      //             }),
                      //         items: fields),
                      //   ),
                      //   Space.w16,
                      //   Expanded(
                      //     flex: 2,
                      //     child: FormBuilderTextField(
                      //       onChanged: (value) =>
                      //           value == '' ? _bloc.onSearch(null) : null,
                      //       controller: controller,
                      //       name: 'Message search',
                      //       decoration: const InputDecoration(
                      //         labelText: 'Message search',
                      //         hintText: 'Message search',
                      //         floatingLabelBehavior: FloatingLabelBehavior.always,
                      //       ),
                      //     ),
                      //   ),
                      //   Space.w16,
                      //   ElevatedButton(
                      //       style: themeData
                      //           .extension<AppButtonTheme>()!
                      //           .primaryElevated,
                      //       onPressed: () => controller.text != ''
                      //           ? _bloc.onSearch(
                      //               Filters(
                      //                   field:
                      //                       field ?? fields.first.value ?? 'id',
                      //                   value: controller.text),
                      //             )
                      //           : null,
                      //       child: const Text('Search')),
                    ],
                  ),
                  Space.h18,
                  Row(
                    children: [
                      CustomSheetWidget(
                        columns: <DataColumn>[
                          for (final title in titles)
                            DataColumn(
                              label: Text(title),
                            ),
                        ],
                        rows: <DataRow>[
                          for (final item in state.models)
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
                                DataCell(SheetText(text: item?.value)),
                              ],
                            ),
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
