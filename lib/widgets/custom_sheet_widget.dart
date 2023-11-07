import 'package:flutter/material.dart';
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
        child: DataTable(
            horizontalMargin: 10,
            columnSpacing: 16,
            checkboxHorizontalMargin: 0,
            showCheckboxColumn: false,
            showBottomBorder: true,
            rows: widget.rows,
            columns: widget.columns),
      );
    }
  }
}
