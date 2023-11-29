import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/categories_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

@RoutePage()
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoriesBloc _bloc = CategoriesBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Id',
      'Parent id',
      'Sort order',
      'Name',
      // 'Description',
      // 'Is home',
      // 'Subcategories title',
    ];

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.categories.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Categories',
                      onSave: () => _bloc.openChange(context, CategoryModel())),
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
                      for (final item in state.categories)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(InkWell(
                                borderRadius: BRadius.r6,
                                onTap: () => _bloc.openChange(context, item),
                                child: Expanded(child: SheetText(text: item?.id)))),
                            DataCell(SheetText(text: item?.parent_id)),
                            DataCell(SheetText(text: item?.sort_order)),
                            DataCell(SheetText(text: item?.name)),
                            // DataCell(SheetText(text: item?.description)),
                            // DataCell(CustomCheckbox(
                            //   value: item?.is_home,
                            //   onChanged: (value) =>
                            //       _bloc.changeIsHome(item, value),
                            // )),
                            // DataCell(
                            //     SheetText(text: item?.subcategories_title)),
                          ],
                        ),
                    ],
                  )
                ],
              ),
            ));
          }
        });
  }
}
