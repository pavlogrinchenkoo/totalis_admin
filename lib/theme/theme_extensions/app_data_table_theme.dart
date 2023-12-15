import 'package:flutter/material.dart';
import 'package:totalis_admin/style.dart';

class AppDataTableTheme extends ThemeExtension<AppDataTableTheme> {
  final CardTheme cardTheme;
  final DataTableThemeData dataTableThemeData;

  const AppDataTableTheme({
    required this.cardTheme,
    required this.dataTableThemeData,
  });

  factory AppDataTableTheme.fromTheme(ThemeData themeData) {
    return AppDataTableTheme(
      cardTheme: themeData.cardTheme.copyWith(
        color: Colors.transparent,
        elevation: 0.0,
      ),
      dataTableThemeData: themeData.dataTableTheme.copyWith(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.transparent, width: 1)),
        headingRowColor: MaterialStateProperty.all(Colors.transparent),
        headingTextStyle: TextStyle(color: BC.black),
        dataTextStyle: TextStyle(color: BC.black),
      ),
    );
  }

  @override
  ThemeExtension<AppDataTableTheme> copyWith({
    CardTheme? cardTheme,
    DataTableThemeData? dataTableThemeData,
  }) {
    return AppDataTableTheme(
      cardTheme: cardTheme ?? this.cardTheme,
      dataTableThemeData: dataTableThemeData ?? this.dataTableThemeData,
    );
  }

  @override
  ThemeExtension<AppDataTableTheme> lerp(
      ThemeExtension<AppDataTableTheme>? other, double t) {
    if (other is! AppDataTableTheme) {
      return this;
    }

    return AppDataTableTheme(
      cardTheme: other.cardTheme,
      dataTableThemeData: other.dataTableThemeData,
    );
  }

// final ThemeData dataTable;
//
// const AppDataTableTheme({
//   required this.dataTable,
// });
//
// factory AppDataTableTheme.fromTheme(ThemeData themeData) {
//   return AppDataTableTheme(
//     dataTable: themeData.copyWith(
//       cardTheme: themeData.cardTheme.copyWith(
//         color: Colors.transparent,
//         elevation: 0.0,
//       ),
//       dataTableTheme: DataTableThemeData(
//         headingRowColor: MaterialStateProperty.all(themeData.colorScheme.primary),
//         headingTextStyle: TextStyle(color: themeData.colorScheme.onPrimary),
//       ),
//     ),
//   );
// }
//
// @override
// ThemeExtension<AppDataTableTheme> copyWith({
//   ThemeData? dataTable,
// }) {
//   return AppDataTableTheme(
//     dataTable: dataTable ?? this.dataTable,
//   );
// }
//
// @override
// ThemeExtension<AppDataTableTheme> lerp(ThemeExtension<AppDataTableTheme>? other, double t) {
//   if (other is! AppDataTableTheme) {
//     return this;
//   }
//
//   return AppDataTableTheme(
//     dataTable: other.dataTable,
//   );
// }
}
