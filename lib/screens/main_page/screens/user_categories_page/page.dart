import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Id',
      'User id',
      'Category id',
    ];

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.userCategories.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'User categories',
                      onSave: () =>
                          _bloc.openChange(context, UserCategoryModel())),
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
                            for (final item in state.userCategories)
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(InkWell(
                                      borderRadius: BRadius.r6,
                                      onTap: () => _bloc.openChange(
                                          context, item,
                                          widget: CheckInWidget(id: item?.id)),
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
                                      onTap: () async => _blocUsers.openChange(
                                          context,
                                          await _blocUsers
                                              .getUser(item?.user_id)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: SheetText(
                                                  text: item?.user_id)),
                                          Space.w16,
                                          const CustomOpenIcon()
                                        ],
                                      ))),
                                  DataCell(InkWell(
                                      borderRadius: BRadius.r6,
                                      onTap: () async => _blocCategories.openChange(
                                          context, await _blocCategories.getCategory(
                                              item?.category_id
                                          )),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: SheetText(
                                                  text: item?.category_id)),
                                          Space.w16,
                                          const CustomOpenIcon()
                                        ],
                                      ))),
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
