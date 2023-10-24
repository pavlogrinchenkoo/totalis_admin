import 'package:flutter/material.dart';
import 'package:totalis_admin/api/coaches/dto.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_circle_avatar.dart';
import 'package:totalis_admin/widgets/custom_open_icon.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

class CustomSheetsWidget extends StatefulWidget {
  const CustomSheetsWidget(
      {required this.items, required this.openChange, super.key});

  final List<CoachesModel?> items;
  final void Function(CoachesModel? item) openChange;

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
      'Prompt',
      'Description',
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
                DataCell(InkWell(
                    borderRadius: BRadius.r6,
                    onTap: () => widget.openChange(item),
                    child: Row(
                      children: [
                        Expanded(child: SheetText(text: item?.id)),
                        Space.w16,
                        const CustomOpenIcon()
                      ],
                    ))),
                DataCell(Row(
                  children: [
                    CustomCircle(image: item?.avatar ?? ''),
                    Space.w16,
                    SheetText(text: item?.name),
                  ],
                )),
                DataCell(SheetText(text: item?.prompt)),
                DataCell(SheetText(text: item?.description)),
              ],
            ),
        ],
      );
    }
  }
}
