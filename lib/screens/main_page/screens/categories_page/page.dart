import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/categories_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
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
  final ScrollController _scrollController = ScrollController();

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Categories',
                      onSave: () => _bloc.openChange(context, CategoryModel())),
                  Space.h18,
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
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
                              dataRowHeight: 0,
                              rows: [],
                              // rows: <DataRow>[
                              //   for (final CategoryModel? item
                              //       in state.categories)
                              //     DataRow(
                              //       cells: <DataCell>[
                              //         DataCell(InkWell(
                              //             borderRadius: BRadius.r6,
                              //             onTap: () =>
                              //                 _bloc.openChange(context, item),
                              //             child: Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.center,
                              //               children: [
                              //                 SheetText(text: item?.id),
                              //               ],
                              //             ))),
                              //         DataCell(
                              //             SheetText(text: item?.parent_id)),
                              //         DataCell(
                              //             SheetText(text: item?.sort_order)),
                              //         DataCell(SheetText(text: item?.name)),
                              //         // DataCell(SheetText(text: item?.description)),
                              //         // DataCell(CustomCheckbox(
                              //         //   value: item?.is_home,
                              //         //   onChanged: (value) =>
                              //         //       _bloc.changeIsHome(item, value),
                              //         // )),
                              //         // DataCell(
                              //         //     SheetText(text: item?.subcategories_title)),
                              //       ],
                              //     ),
                              // ],
                            ),
                          ],
                        ),
                        ReorderableListView(
                            shrinkWrap: true,
                            children: [
                              // for (final CategoryModel? item
                              //     in state.categories)
                              for (int index = 0;
                                  index < state.categories.length;
                                  index += 1)
                                Container(
                                  key: ValueKey(state.categories[index]?.id),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: BC.gray)),
                                  ),
                                  child: ListTile(
                                    textColor: BC.black,
                                    focusColor: BC.lightGreen,
                                    selectedColor: BC.white,
                                    selectedTileColor: BC.lightGreen,
                                    dense: false,
                                    title: Container(
                                      child: Row(
                                        children: [
                                          InkWell(
                                              borderRadius: BRadius.r6,
                                              onTap: () => _bloc.openChange(
                                                  context,
                                                  state.categories[index]),
                                              child: SizedBox(
                                                width: 20,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SheetText(
                                                        text: state
                                                            .categories[index]
                                                            ?.id),
                                                  ],
                                                ),
                                              )),
                                          Space.w8,
                                          SizedBox(
                                            width: 54,
                                            child: Center(
                                              child: SheetText(
                                                  text: state.categories[index]
                                                      ?.parent_id),
                                            ),
                                          ),
                                          Space.w16,
                                          SizedBox(
                                            width: 64,
                                            child: Center(
                                              child: SheetText(
                                                  text: state.categories[index]
                                                      ?.sort_order),
                                            ),
                                          ),
                                          Space.w16,
                                          SheetText(
                                              text:
                                                  state.categories[index]?.name)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ],
                            onReorder: (int oldIndex, int newIndex) =>
                                _bloc.reorder(oldIndex, newIndex)),
                      ],
                    ),
                  )
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
