// import 'package:flutter/material.dart';
//
// class CustomTextEdittingController extends TextEditingController {
//   final List<String> listErrorTexts;
//
//   CustomTextEdittingController({String? text, this.listErrorTexts = const []})
//       : super(text: text);
//
//   @override
//   TextSpan buildTextSpan(
//       {required BuildContext context,
//       TextStyle? style,
//       required bool withComposing}) {
//     final List<TextSpan> children = [];
//     if (listErrorTexts.isEmpty) {
//       return TextSpan(text: text, style: style);
//     }
//     try {
//       text.splitMapJoin(
//           RegExp(r'\b(' + listErrorTexts.join('|').toString() + r')+\b'),
//           onMatch: (m) {
//         children.add(TextSpan(
//           text: m[0],
//           style: style!.copyWith(
//               decoration: TextDecoration.underline,
//               decorationStyle: TextDecorationStyle.wavy,
//               decorationColor: Colors.red),
//         ));
//         return "";
//       }, onNonMatch: (n) {
//         children.add(TextSpan(text: n, style: style));
//         return n;
//       });
//     } on Exception catch (e) {
//       return TextSpan(text: text, style: style);
//     }
//     return TextSpan(children: children, style: style);
//   }
// }
//
// void _handleOnChange(String text) {
//   _handleSpellCheck(text, true);
// }
//
// void _handleSpellCheck(String text, bool ignoreLastWord) {
//   if (!text.contains(' ')) {
//     return;
//   }
//   final List<String> arr = text.split(' ');
//   if (ignoreLastWord) {
//     arr.removeLast();
//   }
//   for (var word in arr) {
//     if (word.isEmpty) {
//       continue;
//     } else if (_isWordHasNumberOrBracket(word)) {
//       continue;
//     }
//     final wordToCheck = word.replaceAll(RegExp(r"[^\s\w]"), '');
//     final wordToCheckInLowercase = wordToCheck.toLowerCase();
//     if (!listTexts.contains(wordToCheckInLowercase)) {
//       listTexts.add(wordToCheckInLowercase);
//       if (!listEnglishWords.contains(wordToCheckInLowercase)) {
//         listErrorTexts.add(wordToCheck);
//       }
//     }
//   }
// }
//
// bool _isWordHasNumberOrBracket(String s) {
//   return s.contains(RegExp(r'[0-9\()]'));
// }