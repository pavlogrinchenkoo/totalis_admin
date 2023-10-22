import 'package:flutter/material.dart';
import 'package:totalis_admin/style.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({super.key, this.value, this.onChanged});

  final bool? value;
  final void Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onChanged!(!(value ?? false)),
        child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                color: value ?? false ? BC.lightGreen : BC.white,
                borderRadius: BRadius.r2,
                border: Border.all(color: BC.lightGreen, width: 1)),
            child: value ?? false ? Icon(Icons.check, color: BC.white) : null));
  }
}
