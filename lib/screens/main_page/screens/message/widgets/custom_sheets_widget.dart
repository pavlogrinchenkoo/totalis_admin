import 'package:flutter/material.dart';
import 'package:totalis_admin/api/variable/dto.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

class CustomSheetsWidget extends StatefulWidget {
  const CustomSheetsWidget({required this.items, super.key});

  final List<VariableModel?> items;

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
      'Name',
      'Value',
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
                DataCell(SheetText(text: item?.name)),
                DataCell(SheetText(text: item?.value)),
              ],
            ),
        ],
      );
    }
  }
}
