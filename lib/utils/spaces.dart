import 'package:flutter/material.dart';

class Space {
  static Widget get w52 => const _SpaceWidget(width: 52);

  static Widget get w22 => const _SpaceWidget(width: 22);

  static Widget get w20 => const _SpaceWidget(width: 20);

  static Widget get w16 => const _SpaceWidget(width: 16);

  static Widget get w8 => const _SpaceWidget(width: 8);

  static Widget get w4 => const _SpaceWidget(width: 4);

  static Widget get h140 => const _SpaceWidget(height: 140);

  static Widget get h96 => const _SpaceWidget(height: 96);

  static Widget get h80 => const _SpaceWidget(height: 80);

  static Widget get h32 => const _SpaceWidget(height: 32);

  static Widget get h24 => const _SpaceWidget(height: 24);

  static Widget get h16 => const _SpaceWidget(height: 16);

  static Widget get h8 => const _SpaceWidget(height: 8);
}

class _SpaceWidget extends StatelessWidget {
  const _SpaceWidget({this.width = 0, this.height = 0});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}
