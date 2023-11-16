import 'package:flutter/material.dart';
import 'package:totalis_admin/utils/custom_checkbox.dart';

class CheckItem extends StatelessWidget {
  const CheckItem({this.text, this.isSelected, this.onTap, super.key});

  final String? text;
  final bool? isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onTap?.call(),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(text ?? ''), CustomCheckbox(value: isSelected)]),
        ),
      ),
    );
  }
}
