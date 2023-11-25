import 'package:flutter/material.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:totalis_admin/utils/spaces.dart';

import 'package:totalis_admin/constants/dimens.dart';

class CustomSheetHeaderWidget extends StatelessWidget {
  const CustomSheetHeaderWidget({this.title, this.onSave, this.customText,  super.key});

  final String? title;
  final void Function()? onSave;
  final String? customText;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(children: [
      Text(title ?? '', style: BS.reg16.apply(color: BC.white)),
      Space.w52,
      ElevatedButton(
          style: themeData.extension<AppButtonTheme>()!.successElevated,
          onPressed: () => onSave?.call(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding * 0.5),
                child: Icon(
                  customText != null ? Icons.edit : Icons.add,
                  size: (themeData.textTheme.labelLarge!.fontSize! + 4.0),
                ),
              ),
              Text(customText ?? 'Create new'),
            ],
          )),
    ]);
  }
}
