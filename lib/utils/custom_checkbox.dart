import 'package:flutter/material.dart';
import 'package:totalis_admin/style.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key, this.value, this.onChanged});

  final bool? value;
  final void Function(bool value)? onChanged;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      thumbIcon: thumbIcon,
      value: widget.value ?? false,
      activeColor: BC.green,
      onChanged: (value) {
        widget.onChanged!(!(widget.value ?? false));
        setState(() {});
      },
    );
    //   return InkWell(
    //       onTap: () => onChanged!(!(value ?? false)),
    //       child: Container(
    //           width: 26,
    //           height: 26,
    //           decoration: BoxDecoration(
    //               color: value ?? false ? BC.green : BC.gray,
    //               borderRadius: BRadius.r2,
    //               border: Border.all(color: BC.green, width: 1)),
    //           child: value ?? false ? Icon(Icons.check, color: BC.gray) : null));
  }
}
