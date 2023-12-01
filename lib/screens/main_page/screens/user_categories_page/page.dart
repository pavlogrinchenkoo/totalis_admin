import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/categories_page/bloc.dart'
    as cb;
import 'package:totalis_admin/screens/main_page/screens/users_page/bloc.dart'
    as ub;
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

import '../../../../theme/theme_extensions/app_button_theme.dart';
import 'bloc.dart';
import 'widgets/check_in_widget.dart';

@RoutePage()
class UserCategoriesPage extends StatefulWidget {
  const UserCategoriesPage({super.key});

  @override
  State<UserCategoriesPage> createState() => _UserCategoriesPageState();
}

class _UserCategoriesPageState extends State<UserCategoriesPage> {
  final UserCategoriesBloc _bloc = UserCategoriesBloc();
  final cb.CategoriesBloc _blocCategories = cb.CategoriesBloc();
  final ub.UsersBloc _blocUsers = ub.UsersBloc();
  List<DropdownMenuItem<String>> fields =
      ['id', 'category_id', 'user_id'].map((e) {
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
      'User id',
      'Category id',
    ];

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.items.isEmpty) {
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
                          title: 'User categories',
                          onSave: () =>
                              _bloc.openChange(context, UserCategoryModel())),
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
                          for (final item in state.items)
                            DataRow(
                              cells: <DataCell>[
                                DataCell(InkWell(
                                    borderRadius: BRadius.r6,
                                    onTap: () => _bloc.openChange(context, item,
                                        widget: CheckInWidget(id: item?.id)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SheetText(text: item?.id),
                                      ],
                                    ))),
                                DataCell(InkWell(
                                    borderRadius: BRadius.r6,
                                    onTap: () async => _blocUsers.openChange(
                                        context,
                                        await _blocUsers
                                            .getUser(item?.user_id)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SheetText(text: item?.user_id),
                                      ],
                                    ))),
                                DataCell(InkWell(
                                    borderRadius: BRadius.r6,
                                    onTap: () async =>
                                        _blocCategories.openChange(
                                            context,
                                            await _blocCategories.getCategory(
                                                item?.category_id)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SheetText(text: item?.category_id),
                                      ],
                                    ))),
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

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      _bloc.uploadItems();
    }
  }
}
