import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/screens/main_page/screens/admins_page/bloc.dart';
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
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(80),
        children: [
          if (title != null)
            Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  title ?? '',
                  style: BS.sb32,
                )),
          Space.h80,
          for (final field in fields ?? []) CustomFieldWidget(field: field),
          Space.h24,
          CustomButton(title: 'Save', onTap: onSave),
        ],
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
        children: [
          Text(widget.field?.title ?? ''),
          CupertinoTextField(
            controller: widget.field?.controller,
            enabled: widget.field?.disable,
          ),
        ],
      );
    } else if (widget.field?.type == FieldType.checkbox) {
      return Column(
        children: [
          Text(widget.field?.title ?? ''),
          CustomCheckbox(
              value: widget.field?.value,
              onChanged: (value) => onChanged(value)),
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
