import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_checkbox.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_buttom.dart';

@RoutePage()
class ChangePage extends StatelessWidget {
  const ChangePage({this.fields, this.title, this.onSave, super.key});

  final List<FieldModel>? fields;
  final String? title;
  final void Function()? onSave;

  @override
  Widget build(BuildContext context) {
    fields?.sort((a, b) => a.type == FieldType.checkbox ? 1 : -1);
    fields?.sort((a, b) => a.type == FieldType.bigText ? 1 : -1);

    return Scaffold(
      body: SizedBox(
        child: ListView(
          padding: const EdgeInsets.all(80),
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (title != null)
                Text(
                  title ?? '',
                  style: BS.sb32,
                ),
              Space.h32,
              Wrap(spacing: 16, children: [
                for (final field in fields ?? [])
                  Container(
                    width: 400,
                    padding: const EdgeInsets.only(top: 24),
                    child: CustomFieldWidget(field: field),
                  ),
              ]),
              Space.h24,
            ]),
            Center(
                child: SizedBox(
                    width: 400,
                    child: CustomButton(title: 'Save', onTap: onSave))),
          ],
        ),
      ),
    );
  }
}

class CustomFieldWidget extends StatefulWidget {
  const CustomFieldWidget({this.field, super.key});

  final FieldModel? field;

  @override
  State<CustomFieldWidget> createState() => _CustomFieldWidgetState();
}

class _CustomFieldWidgetState extends State<CustomFieldWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.field?.type == FieldType.text) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? '', style: BS.reg16),
          Space.h8,
          CupertinoTextField(
            controller: widget.field?.controller,
            enabled: widget.field?.enable,
          ),
        ],
      );
    } else if (widget.field?.type == FieldType.bigText) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? '', style: BS.reg16),
          Space.h8,
          CupertinoTextField(
            minLines: 5,
            maxLines: 5,
            controller: widget.field?.controller,
            enabled: widget.field?.enable,
          ),
        ],
      );
    } else if (widget.field?.type == FieldType.checkbox) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? '', style: BS.reg16),
          Space.h8,
          CustomCheckbox(
              value: widget.field?.value,
              onChanged: (value) => onChanged(value)),
        ],
      );
    } else if (widget.field?.type == FieldType.email) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? '', style: BS.reg16),
          Space.h8,
          CupertinoTextField(
            controller: widget.field?.controller,
            enabled: widget.field?.enable,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      );
    } else if (widget.field?.type == FieldType.avatar) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? '', style: BS.reg16),
          Space.h8,
          _AvatarWidget(
              base64: widget.field?.base64 ?? '',
              onChange: (image) => widget.field?.base64 = image),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  onChanged(bool value) {
    widget.field?.value = value;
    setState(() {});
  }
}

class _AvatarWidget extends StatefulWidget {
  const _AvatarWidget({this.base64 = '', super.key, required this.onChange});

  final String base64;
  final void Function(String image) onChange;

  @override
  State<_AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<_AvatarWidget> {
  late Uint8List bytesImage;

  @override
  void initState() {
    bytesImage = const Base64Decoder().convert(widget.base64);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 165,
        height: 140,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: BC.black)),
        child: Row(
          children: [
            Expanded(
                child: bytesImage.isNotEmpty
                    ? Image.memory(bytesImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity)
                    : Container(color: BC.gray)),
            Container(
              color: BC.green,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        splashRadius: 10,
                        onPressed: () => _trashPhoto(),
                        icon: Icon(Icons.delete_outline, color: BC.white)),
                    IconButton(
                        splashRadius: 10,
                        onPressed: () => _downloadPhoto(),
                        icon: Icon(Icons.download, color: BC.white)),
                    IconButton(
                        splashRadius: 10,
                        onPressed: () => _uploadPhoto(),
                        icon: Icon(Icons.change_circle_outlined,
                            color: BC.white)),
                  ]),
            )
          ],
        ));
  }

  _trashPhoto() {
    widget.onChange(base64.encode(Uint8List(0)));
    setState(() {
      bytesImage = Uint8List(0);
    });
  }

  _downloadPhoto() async {
    if (bytesImage.isNotEmpty) {
      await WebImageDownloader.downloadImageFromUInt8List(
          uInt8List: bytesImage);
    }
  }

  _uploadPhoto() async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    if (bytesFromPicker != null) {
      widget.onChange(base64.encode(bytesFromPicker));
      setState(() {
        bytesImage = bytesFromPicker;
      });
    }
  }
}

class FieldModel {
  String? title;
  TextEditingController? controller;
  String? base64;
  bool? value;
  FieldType? type;
  bool? enable;
  bool required;

  FieldModel(
      {this.title = '',
      this.controller,
      this.base64,
      this.value,
      this.type = FieldType.text,
      this.enable = true,
      this.required = false}) {
    if (type == FieldType.text && controller == null) {
      controller = TextEditingController();
    }
  }
}

enum FieldType { checkbox, text, bigText, email, avatar }
