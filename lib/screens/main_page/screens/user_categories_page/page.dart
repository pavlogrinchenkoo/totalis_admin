import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:totalis_admin/admin_ui/lib/constants/dimens.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/user_categories_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:totalis_admin/utils/custom_checkbox.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_buttom.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

import '../../../../widgets/custom_sheet_widget.dart';

@RoutePage()
class UserCategoriesPage extends StatefulWidget {
  const UserCategoriesPage({super.key});

  @override
  State<UserCategoriesPage> createState() => _UserCategoriesPageState();
}

class _UserCategoriesPageState extends State<UserCategoriesPage> {
  final UserCategoriesBloc _bloc = UserCategoriesBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final titles = [
      'Id',
      'User id',
      'Category id',
      'Is favorite',
      'Muted day',
      'Muted for',
      'Chat summary long',
      'Chat summary short',
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
                                  DataCell(SheetText(text: item?.user_id)),
                                  DataCell(SheetText(text: item?.category_id)),
                                  DataCell(CustomCheckbox(
                                    value: item?.is_favorite,
                                    onChanged: (value) =>
                                        _bloc.changeIsFavorite(item, value),
                                  )),
                                  DataCell(SheetText(text: item?.muted_day)),
                                  DataCell(SheetText(text: item?.muted_for)),
                                  DataCell(
                                      SheetText(text: item?.chat_summary_long)),
                                  DataCell(SheetText(
                                      text: item?.chat_summary_short)),
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
