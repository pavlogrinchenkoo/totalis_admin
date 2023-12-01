import 'package:flutter/material.dart';
import 'package:totalis_admin/admin_ui/lib/constants/dimens.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

List<String> getTitlesCustom({required List<dynamic>? items}) {
  if (items != null && items.isNotEmpty) {
    final first = items.first.toJson();
    final keys = <String>[];
    keys.addAll(first.keys);

    return keys;
  } else {
    return [];
  }
}

String getFileExtension(String fileName) {
  try {
    return ".${fileName.split('.').last}";
  } catch (e) {
    return '';
  }
}

bool containsInt(String? value) {
  return value?.contains('id') ?? false;
}

bool containsLevel(String? value) {
  return value?.contains('level') ?? false;
}

void showCustomDialog(BuildContext context, DialogType dialogType,
    Function() onPress, Function() onCancel) {
  final dialog = AwesomeDialog(
    context: context,
    dialogType: dialogType,
    title: 'Delete?',
    width: kDialogWidth,
    btnOkOnPress: onPress,
    btnCancelOnPress: onCancel,
  );

  dialog.show();
}
