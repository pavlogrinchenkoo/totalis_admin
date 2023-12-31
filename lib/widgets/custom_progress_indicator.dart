import 'package:flutter/material.dart';
import 'package:totalis_admin/style.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: SizedBox(
                width: 38,
                height: 38,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: BC.green))),
      ],
    );
  }
}
