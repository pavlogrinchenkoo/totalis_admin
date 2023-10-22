import 'package:flutter/material.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_checkbox.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

class CustomSheetsWidget extends StatefulWidget {
  const CustomSheetsWidget(
      {required this.items, super.key, required this.onChangeIsFavorite});

  final List<CategoryModel?> items;
  final void Function(CategoryModel? item, bool value) onChangeIsFavorite;

  @override
  State<CustomSheetsWidget> createState() => _CustomSheetsWidgetState();
}

class _CustomSheetsWidgetState extends State<CustomSheetsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Id',
      'Parent id',
      'Sort order',
      'Description',
      'Is home',
      'Subcategories title',
    ];
    if (widget.items.isEmpty) {
      return const SizedBox();
    } else {
      return DataTable(
        border: TableBorder.all(
            width: 1, color: BC.black, borderRadius: BRadius.r12),
        columns: <DataColumn>[
          for (final title in titles)
            DataColumn(
              label: Expanded(
                child: Text(
                  title,
                  style: BS.sb20.apply(color: BC.lightGreen),
                ),
              ),
            ),
        ],
        rows: <DataRow>[
          for (final item in widget.items)
            DataRow(
              cells: <DataCell>[
                DataCell(SheetText(text: item?.id)),
                DataCell(SheetText(text: item?.parent_id)),
                DataCell(SheetText(text: item?.sort_order)),
                DataCell(SheetText(text: item?.description)),
                DataCell(CustomCheckbox(
                  value: item?.is_home,
                  onChanged: (value) => widget.onChangeIsFavorite(item, value),
                )),
                DataCell(SheetText(text: item?.subcategories_title)),
              ],
            ),
        ],
      );
    }
  }
}
