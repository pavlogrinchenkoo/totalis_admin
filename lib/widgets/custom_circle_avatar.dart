import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totalis_admin/api/images/dto.dart';
import 'package:totalis_admin/api/images/request.dart';
import 'package:totalis_admin/style.dart';

class CustomCircle extends StatefulWidget {
  const CustomCircle({this.imageId, super.key});

  final int? imageId;

  @override
  State<CustomCircle> createState() => _CustomCircleState();
}

class _CustomCircleState extends State<CustomCircle> {
  final ImageRequest _imageRequest = ImageRequest();
  ImageModel image = ImageModel();

  @override
  void initState() {
    _loadImage(widget.imageId);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomCircle oldWidget) {
    _loadImage(widget.imageId);
    super.didUpdateWidget(oldWidget);
  }

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
          child: image.data != null && image.data != ""
              ? Image.memory(_createFileFromString(image.data!),
                  fit: BoxFit.cover)
              : const SizedBox()),
    );
  }

  Future<void> _loadImage(int? imageId) async {
    final res = await _imageRequest.get(imageId.toString());
    if (res == null) return;

    setState(() {
      image = res;
    });
  }
}

Uint8List _createFileFromString(String base64) {
  Uint8List bytes = base64Decode(base64);
  return bytes;
}
