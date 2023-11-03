import 'package:flutter/material.dart';
import 'package:totalis_admin/generated/assets.gen.dart';
import 'package:totalis_admin/style.dart';

class CustomOpenIcon extends StatelessWidget {
  const CustomOpenIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: BC.green, borderRadius: BRadius.r6),
        child: Assets.open.svg());
  }
}
