import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totalis_admin/style.dart';

class CustomCircle extends StatelessWidget {
  const CustomCircle({this.image, super.key});

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BRadius.r64,
        color: BC.lightGreen,
      ),
      child: ClipRRect(
          borderRadius: BRadius.r64,
          child: image != 'tetst'
              ? Image.memory(_createFileFromString(image ?? ''))
              : const SizedBox()),
    );
  }
}

Uint8List _createFileFromString(String base64) {
  Uint8List bytes = base64Decode(base64);
  return bytes;
}
