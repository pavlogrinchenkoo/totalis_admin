import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
            ),
            CustomButton(title: 'Save', onTap: onSave),
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
    } else {
      return const SizedBox();
    }
  }

  onChanged(bool value) {
    widget.field?.value = value;
    setState(() {});
  }
}

class FieldModel {
  String? title;
  TextEditingController? controller;
  bool? value;
  FieldType? type;
  bool? enable;

  FieldModel(
      {this.title = '',
      this.controller,
      this.value,
      this.type = FieldType.text,
      this.enable = true}) {
    if (type == FieldType.text && controller == null) {
      controller = TextEditingController();
    }
  }
}

enum FieldType { checkbox, text, bigText, email }
