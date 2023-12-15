import 'package:flutter/material.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/theme/theme_extensions/app_data_table_theme.dart';

class CustomSheetWidget extends StatefulWidget {
  const CustomSheetWidget(
      {super.key, required this.columns, required this.rows});

  final List<DataColumn> columns;
  final List<DataRow> rows;

  @override
  State<CustomSheetWidget> createState() => _CustomSheetWidgetState();
}

class _CustomSheetWidgetState extends State<CustomSheetWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>();

    if (widget.columns.isEmpty) {
      return const SizedBox();
    } else {
      return Theme(
        data: themeData.copyWith(
          cardTheme: appDataTableTheme?.cardTheme,
          dataTableTheme: appDataTableTheme?.dataTableThemeData,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                // set height 40
                height: 45,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: BC.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            DataTable(
                horizontalMargin: 10,
                dataRowMaxHeight: double.infinity,
                // Code to be changed.
                dataRowMinHeight: 60,
                columnSpacing: 16,
                checkboxHorizontalMargin: 0,
                showCheckboxColumn: false,
                showBottomBorder: true,
                rows: widget.rows,
                columns: widget.columns),
          ],
        ),
      );
    }
  }
}
