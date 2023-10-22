import 'package:flutter/material.dart';
import 'package:totalis_admin/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({this.icon, this.onTap, this.title = '', super.key});

  final Widget? icon;
  final void Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BRadius.r64,
      color: BC.lightGreen,
      child: InkWell(
          borderRadius: BRadius.r64,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Center(
                child: Text(title, style: BS.med20.apply(color: BC.white))),
          )),
    );
  }
}
