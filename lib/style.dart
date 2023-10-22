import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeColors {
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color gray = Color(0xffE3E3E3);
  static const Color darkGray = Color(0xff363636);
  static const Color boxShadow = Color(0x33000000);
  static const Color boxShadowLight = Color(0x1A000000);
  static const Color green = Color(0xff547D53);
  static const Color lightGreen = Color(0xff1B9019);
  static const Color blue = Color(0xff00A3FF);
  static const Color red = Color(0xffFF6161);
  static const Color avatarGrey = Color(0xff777272);
}

abstract class BC {
  static Color get white => ThemeColors.white;

  static Color get black => ThemeColors.black;

  static Color get gray => ThemeColors.gray;

  static Color get darkGray => ThemeColors.darkGray;

  static Color get boxShadow => ThemeColors.boxShadow;

  static Color get boxShadowLight => ThemeColors.boxShadowLight;

  static Color get green => ThemeColors.green;

  static Color get lightGreen => ThemeColors.lightGreen;

  static Color get blue => ThemeColors.blue;

  static Color get red => ThemeColors.red;

  static Color get avatarGrey => ThemeColors.avatarGrey;
}

abstract class BS {
  static TextStyle get bold36 => GoogleFonts.openSans(
      color: BC.black, fontSize: 36, fontWeight: FontWeight.w700);

  static TextStyle get sb32 => GoogleFonts.openSans(
      color: BC.black, fontSize: 32, fontWeight: FontWeight.w600);

  static TextStyle get sb24 => GoogleFonts.openSans(
      color: BC.black, fontSize: 24, fontWeight: FontWeight.w600);

  static TextStyle get sb20 => GoogleFonts.openSans(
      color: BC.black, fontSize: 20, fontWeight: FontWeight.w600);

  static TextStyle get med20 => GoogleFonts.openSans(
      color: BC.black, fontSize: 20, fontWeight: FontWeight.w500);

  static TextStyle get reg16 => GoogleFonts.openSans(
      color: BC.black, fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle get light14 => GoogleFonts.openSans(
      color: BC.black, fontSize: 14, fontWeight: FontWeight.w300);
}

abstract class BDuration {
  static Duration get d200 => const Duration(milliseconds: 200);

  static Duration get d100 => const Duration(milliseconds: 100);
}

abstract class BRadius {
  static BorderRadius get r2 => const BorderRadius.all(Radius.circular(2));

  static BorderRadius get r6 => const BorderRadius.all(Radius.circular(6));

  static BorderRadius get r12 => const BorderRadius.all(Radius.circular(12));

  static BorderRadius get r16 => const BorderRadius.all(Radius.circular(16));

  static BorderRadius get r64 => const BorderRadius.all(Radius.circular(64));
}

abstract class BShadow {
  static List<BoxShadow> get def => [
        BoxShadow(
            color: BC.boxShadow, blurRadius: 60, offset: const Offset(2, 2))
      ];

  static List<BoxShadow> get light => [
        BoxShadow(
            color: BC.boxShadowLight,
            blurRadius: 60,
            offset: const Offset(0, 2))
      ];
}
