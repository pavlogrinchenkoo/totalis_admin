import 'package:flutter/material.dart';
import 'package:totalis_admin/admin_ui/lib/constants/dimens.dart';
import 'package:totalis_admin/style.dart';

import 'theme_extensions/app_button_theme.dart';
import 'theme_extensions/app_color_scheme.dart';
import 'theme_extensions/app_data_table_theme.dart';
import 'theme_extensions/app_sidebar_theme.dart';

const Color kPrimaryColor = Color(0xFF347BDE);
const Color kSecondaryColor = Color(0xFF6C757D);
const Color kErrorColor = Color(0xFFDC3545);
const Color kSuccessColor = Color(0xFF08A158);
const Color kInfoColor = Color(0xFF17A2B8);
const Color kWarningColor = Color(0xFFFFc107);

const Color kTextColor = Color(0xFF2A2B2D);

const Color kScreenBackgroundColor = Color(0xFF343A40);

class AppThemeData {
  AppThemeData._();

  static final AppThemeData _instance = AppThemeData._();

  static AppThemeData get instance => _instance;

  ThemeData light() {
    final themeData = ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      scaffoldBackgroundColor: BC.white,
      drawerTheme:
          const DrawerThemeData(backgroundColor: kScreenBackgroundColor),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: kPrimaryColor,
        onPrimary: Colors.white,
        secondary: kSecondaryColor,
        onSecondary: Colors.white,
        error: kErrorColor,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      cardTheme: const CardTheme(
        margin: EdgeInsets.zero,
      ),
    );

    final appColorScheme = AppColorScheme(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
      success: kSuccessColor,
      info: kInfoColor,
      warning: kWarningColor,
      hyperlink: const Color(0xFF0074CC),
      buttonTextBlack: kTextColor,
      buttonTextDisabled: kTextColor.withOpacity(0.38),
    );

    final appSidebarTheme = AppSidebarTheme(
      backgroundColor: themeData.drawerTheme.backgroundColor!,
      foregroundColor: const Color(0xFFC2C7D0),
      sidebarWidth: 304.0,
      sidebarLeftPadding: kDefaultPadding,
      sidebarTopPadding: kDefaultPadding,
      sidebarRightPadding: kDefaultPadding,
      sidebarBottomPadding: kDefaultPadding,
      headerUserProfileRadius: 20.0,
      headerUsernameFontSize: 14.0,
      headerTextButtonFontSize: 14.0,
      menuFontSize: 14.0,
      menuBorderRadius: 5.0,
      menuLeftPadding: 0.0,
      menuTopPadding: 2.0,
      menuRightPadding: 0.0,
      menuBottomPadding: 2.0,
      menuHoverColor: Colors.white.withOpacity(0.2),
      menuSelectedFontColor: Colors.white,
      menuSelectedBackgroundColor: appColorScheme.primary,
      menuExpandedBackgroundColor: Colors.white.withOpacity(0.1),
      menuExpandedHoverColor: Colors.white.withOpacity(0.1),
      menuExpandedChildLeftPadding: 4.0,
      menuExpandedChildTopPadding: 2.0,
      menuExpandedChildRightPadding: 4.0,
      menuExpandedChildBottomPadding: 2.0,
    );

    return themeData.copyWith(
      textTheme: themeData.textTheme.apply(

        bodyColor: kTextColor,
        displayColor: kTextColor,
      ),
      extensions: [
        AppButtonTheme.fromAppColorScheme(appColorScheme),
        appColorScheme,
        AppDataTableTheme.fromTheme(themeData),
        appSidebarTheme,
      ],
    );
  }

  final inputDecorationTheme = InputDecorationTheme(
      hintStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return BS.med14.apply(color: BC.black);
        } else {
          return BS.med14.apply(color: BC.black.withOpacity(0.8));
        }
      }),

      labelStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.error)) {
          return TextStyle(color: BC.red);
        } else if (states.contains(MaterialState.focused)) {
          return TextStyle(color: BC.black);
        } else {
          return TextStyle(color: BC.black.withOpacity(0.8));
        }
      }),
      floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.error)) {
          return TextStyle(color: BC.red);
        } else if (states.contains(MaterialState.focused)) {
          return TextStyle(color: BC.black);
        } else {
          return TextStyle(color: BC.black.withOpacity(0.8));
        }
      }),
      // labelStyle: TextStyle(color: BC.white),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: BC.black.withOpacity(0.8), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: BC.black, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: BC.red, width: 1),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: BC.black.withOpacity(0.8), width: 4),
      ));

  ThemeData dark() {
    final themeData = ThemeData.dark().copyWith(
      switchTheme: SwitchThemeData(
          splashRadius: 0.0,
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return BC.green;
            } else if (states.contains(MaterialState.hovered)) {
              return BC.darkGray.withOpacity(0.3);
            } else if (states.contains(MaterialState.focused)) {
              return BC.darkGray.withOpacity(0.5);
            } else if (states.contains(MaterialState.disabled)) {
              return BC.darkGray.withOpacity(0.5);
            }
          })),
      drawerTheme:
          const DrawerThemeData(backgroundColor: kScreenBackgroundColor),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      scaffoldBackgroundColor: BC.white,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: BC.green,
        selectionColor: BC.green.withOpacity(0.2),
        selectionHandleColor: BC.green.withOpacity(0.2),
      ),
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: BC.white,
          onPrimary: BC.white,
          secondary: BC.green,
          onSecondary: BC.green,
          error: BC.red,
          onError: BC.red,
          background: BC.gray,
          onBackground: BC.gray,
          surface: BC.white,
          onSurface: BC.white),
      datePickerTheme: DatePickerThemeData(
        rangePickerElevation: 1,
        elevation: 1,
        backgroundColor: kScreenBackgroundColor,
        headerBackgroundColor: BC.green,
        headerForegroundColor: BC.white,
        rangePickerHeaderForegroundColor: BC.white,
        weekdayStyle: TextStyle(color: BC.white),
        yearForegroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return BC.white;
          } else {
            return BC.white;
          }
        }),
        yearBackgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return BC.green;
          } else if (states.contains(MaterialState.hovered)) {
            return BC.green.withOpacity(0.5);
          } else {
            return Colors.transparent;
          }
        }),
        dayForegroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return BC.white;
          } else {
            return BC.white;
          }
        }),
        dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return BC.green;
          } else if (states.contains(MaterialState.hovered)) {
            return BC.green.withOpacity(0.5);
          } else {
            return Colors.transparent;
          }
        }),
        todayBorder: BorderSide.none,
        todayForegroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return BC.white;
          } else {
            return BC.white;
          }
        }),
        todayBackgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return BC.green;
          } else {
            return BC.white.withOpacity(0.5);
          }
        }),
      ),
      inputDecorationTheme: inputDecorationTheme,
      cardTheme: const CardTheme(
        margin: EdgeInsets.zero,
      ),
    );

    final appColorScheme = AppColorScheme(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
      success: kSuccessColor,
      info: kInfoColor,
      warning: kWarningColor,
      hyperlink: const Color(0xFF6BBBF7),
      buttonTextBlack: kTextColor,
      buttonTextDisabled: Colors.white.withOpacity(0.38),
    );

    final appSidebarTheme = AppSidebarTheme(
      backgroundColor: themeData.drawerTheme.backgroundColor!,
      foregroundColor: const Color(0xFFC2C7D0),
      sidebarWidth: 304.0,
      sidebarLeftPadding: kDefaultPadding,
      sidebarTopPadding: kDefaultPadding,
      sidebarRightPadding: kDefaultPadding,
      sidebarBottomPadding: kDefaultPadding,
      headerUserProfileRadius: 20.0,
      headerUsernameFontSize: 14.0,
      headerTextButtonFontSize: 14.0,
      menuFontSize: 14.0,
      menuBorderRadius: 5.0,
      menuLeftPadding: 0.0,
      menuTopPadding: 2.0,
      menuRightPadding: 0.0,
      menuBottomPadding: 2.0,
      menuHoverColor: Colors.white.withOpacity(0.2),
      menuSelectedFontColor: Colors.white,
      menuSelectedBackgroundColor: appColorScheme.primary,
      menuExpandedBackgroundColor: Colors.white.withOpacity(0.1),
      menuExpandedHoverColor: Colors.white.withOpacity(0.1),
      menuExpandedChildLeftPadding: 4.0,
      menuExpandedChildTopPadding: 2.0,
      menuExpandedChildRightPadding: 4.0,
      menuExpandedChildBottomPadding: 2.0,
    );

    return themeData.copyWith(
      extensions: [
        AppButtonTheme.fromAppColorScheme(appColorScheme),
        appColorScheme,
        AppDataTableTheme.fromTheme(themeData),
        appSidebarTheme,
      ],
    );
  }
}
