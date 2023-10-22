import 'package:flutter/material.dart';
import 'package:totalis_admin/style.dart';

class SheetText extends StatelessWidget {
  const SheetText({this.text, super.key});

  final dynamic text;

  @override
  Widget build(BuildContext context) {
    return Text((text ?? "").toString(), style: BS.reg16);
  }
}
