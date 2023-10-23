import 'package:flutter/material.dart';
import 'package:totalis_admin/style.dart';

class SheetText extends StatelessWidget {
  const SheetText({this.text, super.key});

  final dynamic text;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 200),
        child: Text((text ?? "").toString(),
            style: BS.reg16, maxLines: 2, overflow: TextOverflow.ellipsis));
  }
}
