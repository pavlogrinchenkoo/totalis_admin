import 'package:flutter/material.dart';
import 'package:totalis_admin/constants/dimens.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/spaces.dart';

class CustomSheetHeaderWidget extends StatelessWidget {
  const CustomSheetHeaderWidget(
      {this.title, this.onSave, this.customText, super.key});

  final String? title;
  final void Function()? onSave;
  final String? customText;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(children: [
      Text(title ?? '', style: BS.sb20.apply(color: BC.black)),
      Space.w52,
      FilledButton(
          onPressed: () => onSave?.call(),
          style: FilledButton.styleFrom(
            backgroundColor: BC.green,
          ),
          child: Text(customText ?? 'Create new')),
    ]);
  }
}
