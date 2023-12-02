import 'dart:convert';

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime/mime.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/api/images/dto.dart';
import 'package:totalis_admin/api/images/request.dart';
import 'package:totalis_admin/generated/assets.gen.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/page.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/app_bar_back_button.dart';
import 'package:totalis_admin/widgets/card_elements.dart';
import 'package:totalis_admin/widgets/custom_bottom_sheet_text_field.dart';

@RoutePage()
class ChangePage extends StatelessWidget {
  ChangePage(
      {this.fields,
      this.title,
      this.onSave,
      this.onSavePrompt,
      this.onDelete,
      this.widget,
      this.category,
      super.key});

  final List<FieldModel>? fields;
  final String? title;
  final void Function()? onSave;
  final void Function()? onSavePrompt;
  final void Function()? onDelete;
  final Widget? widget;
  final CategoryModel? category;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    fields?.sort((a, b) => a.type == FieldType.checkbox ? 1 : -1);
    fields?.sort((a, b) => a.type == FieldType.bigText ? 1 : -1);

    if ((fields ?? []).any((field) => field.type == FieldType.avatar)) {
      fields?.sort((a, b) => a.type == FieldType.avatar ? 1 : -1);
    }

    return Scaffold(
      body: SizedBox(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                const AppBarBackButton(),
                Space.w22,
                if (title != null)
                  Text(
                    title ?? '',
                    style: BS.reg16.apply(color: BC.white),
                  ),
              ],
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Space.h32,
              CardBody(
                  padding: EdgeInsets.zero,
                  child: FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Wrap(spacing: 16, children: [
                        for (final field in fields ?? [])
                          Container(
                            width: 400,
                            padding: const EdgeInsets.only(top: 24),
                            child: CustomFieldWidget(
                                field: field,
                                formKey: _formKey,
                                category: category,
                                onSavePrompt: onSavePrompt),
                          ),
                        widget ?? const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(top: 36),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                ElevatedButton(
                                  style: themeData
                                      .extension<AppButtonTheme>()!
                                      .primaryElevated,
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      // Validation passed.
                                      onSave?.call();
                                    } else {
                                      // Validation failed.
                                    }
                                  },
                                  child: const Text('Save'),
                                ),
                                Space.w16,
                                if (onDelete != null)
                                  ElevatedButton(
                                    style: themeData
                                        .extension<AppButtonTheme>()!
                                        .errorElevated,
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        // Validation passed.
                                        onDelete?.call();
                                      } else {
                                        // Validation failed.
                                      }
                                    },
                                    child: const Text('Delete'),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ]))),
              // Space.h24,
            ]),
            // Center(
            //     child: SizedBox(
            //         width: 400,
            //         child: CustomButton(title: 'Save', onTap: onSave))),
          ],
        ),
      ),
    );
  }
}

class CustomFieldWidget extends StatefulWidget {
  const CustomFieldWidget(
      {this.field,
      this.formKey,
      this.onSave,
      this.category,
      this.onSavePrompt,
      super.key});

  final FieldModel? field;
  final GlobalKey<FormBuilderState>? formKey;
  final void Function()? onSave;
  final void Function()? onSavePrompt;
  final CategoryModel? category;

  @override
  State<CustomFieldWidget> createState() => _CustomFieldWidgetState();
}

class _CustomFieldWidgetState extends State<CustomFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    if (widget.field?.type == FieldType.text) {
      return FormBuilderTextField(
        onChanged: (value) => js.context.callMethod('enableSpellCheck'),
        controller: widget.field?.controller,
        enabled: widget.field?.enable ?? true,
        name: widget.field?.title ?? '',
        decoration: InputDecoration(
          labelText: widget.field?.title ?? '',
          hintText: widget.field?.title ?? '',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        validator: (widget.field?.required ?? false)
            ? FormBuilderValidators.required()
            : null,
      );
    } else if (widget.field?.type == FieldType.bigText) {
      return Column(
        children: [
          Stack(
            children: [
              FormBuilderTextField(
                onChanged: (value) => js.context.callMethod('enableSpellCheck'),
                minLines: 10,
                maxLines: 10,
                controller: widget.field?.controller,
                enabled: widget.field?.enable ?? true,
                name: widget.field?.title ?? '',
                decoration: InputDecoration(
                  labelText: widget.field?.title ?? '',
                  hintText: widget.field?.title ?? '',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (widget.field?.required ?? false)
                    ? FormBuilderValidators.required()
                    : null,
              ),
              Positioned(
                  right: 1,
                  bottom: 1,
                  child: InkWell(
                    onTap: () => CustomBottomSheetTextField()
                        .show(context, widget.field),
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: BC.green, borderRadius: BRadius.r6),
                        child: Assets.openBigTextfield.svg()),
                  )),
            ],
          ),
          if (widget.field?.title == 'Prompt' && widget.category?.id != null)
            Column(
              children: [
                Space.h16,
                ElevatedButton(
                  style: themeData.extension<AppButtonTheme>()!.primaryElevated,
                  onPressed: () {
                    if (widget.formKey?.currentState?.validate() ?? false) {
                      // Validation passed.
                      widget.onSave?.call();
                      PromptPreviewBottomSheet().show(context, widget.field,
                          widget.category?.id, widget.onSavePrompt);
                    } else {
                      // Validation failed.
                    }
                  },
                  child: const Text('Prompt preview'),
                ),
              ],
            ),
          if (widget.field?.title == 'Prompt checkin' &&
              widget.category?.id != null)
            Column(
              children: [
                Space.h16,
                ElevatedButton(
                  style: themeData.extension<AppButtonTheme>()!.primaryElevated,
                  onPressed: () {
                    if (widget.formKey?.currentState?.validate() ?? false) {
                      // Validation passed.
                      widget.onSave?.call();
                      PromptPreviewBottomSheet().show(context, widget.field,
                          widget.category?.id, widget.onSavePrompt);
                    } else {
                      // Validation failed.
                    }
                  },
                  child: const Text('Prompt preview'),
                ),
              ],
            ),
          if (widget.field?.title == 'Prompt checkin proposal' &&
              widget.category?.id != null)
            Column(
              children: [
                Space.h16,
                ElevatedButton(
                  style: themeData.extension<AppButtonTheme>()!.primaryElevated,
                  onPressed: () {
                    if (widget.formKey?.currentState?.validate() ?? false) {
                      // Validation passed.
                      widget.onSave?.call();
                      PromptPreviewBottomSheet().show(context, widget.field,
                          widget.category?.id, widget.onSavePrompt);
                    } else {
                      // Validation failed.
                    }
                  },
                  child: const Text('Prompt preview'),
                ),
              ],
            )
        ],
      );
    } else if (widget.field?.type == FieldType.checkbox) {
      return FormBuilderCheckbox(
        checkColor: BC.white,
        activeColor: BC.green,
        name: widget.field?.title ?? '',
        enabled: widget.field?.enable ?? true,
        initialValue: widget.field?.value ?? false,
        onChanged: (value) => onChanged(value ?? false),
        title: Text(widget.field?.title ?? ''),
        validator: FormBuilderValidators.required(),
      );
    } else if (widget.field?.type == FieldType.email) {
      return FormBuilderTextField(
        onChanged: (value) => js.context.callMethod('enableSpellCheck'),
        controller: widget.field?.controller,
        enabled: widget.field?.enable ?? true,
        name: widget.field?.title ?? '',
        decoration: InputDecoration(
          labelText: widget.field?.title ?? '',
          hintText: widget.field?.title ?? '',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        validator: (widget.field?.required ?? false)
            ? FormBuilderValidators.email()
            : null,
      );
    } else if (widget.field?.type == FieldType.dateTime) {
      return FormBuilderDateTimePicker(
        name: widget.field?.title ?? '',
        onChanged: (DateTime? value) {
          if (value != null) {
            widget.field?.controller?.text = (value).toIso8601String();
          }
        },
        inputType: InputType.date,
        decoration: InputDecoration(
          labelText: widget.field?.title ?? '',
          border: const OutlineInputBorder(),
        ),
        initialValue: widget.field?.controller?.text != null &&
                widget.field?.controller?.text != ''
            ? DateTime.parse(widget.field?.controller?.text ?? '')
            : DateTime.now(),
      );
    } else if (widget.field?.type == FieldType.avatar) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.field?.title ?? ''),
          Space.w8,
          _AvatarWidget(
              imageId: widget.field?.imageId,
              onChange: (imageId) => onChangedImageId(imageId)),
        ],
      );
    } else if (widget.field?.type == FieldType.dropdown) {
      return FormBuilderDropdown(
        name: widget.field?.title ?? '',
        decoration: InputDecoration(
          labelText: widget.field?.title ?? '',
          border: const OutlineInputBorder(),
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
        ),
        focusColor: Colors.transparent,
        onChanged: (value) => widget.field?.enumValue = value,
        validator: FormBuilderValidators.required(),
        initialValue: widget.field?.enumValue,
        items: (widget.field?.values ?? [])
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
      );
    } else if (widget.field?.type == FieldType.enums) {
      return FormBuilderDropdown(
        name: widget.field?.title ?? '',
        decoration: InputDecoration(
          labelText: widget.field?.title ?? '',
          border: const OutlineInputBorder(),
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
        ),
        focusColor: Colors.transparent,
        onChanged: (value) => widget.field?.enumValue = value,
        validator: FormBuilderValidators.required(),
        initialValue: widget.field?.enumValue,
        items: (widget.field?.values ?? [])
            .map((e) => DropdownMenuItem(
                value: e, child: Text(e.toString().split('.').last)))
            .toList(),
      );
    } else {
      return const SizedBox();
    }
  }

  onChanged(bool value) {
    widget.field?.value = value;
    setState(() {});
  }

  onChangedImageId(int? value) {
    widget.field?.imageId = value;
    setState(() {});
  }
}

class _AvatarWidget extends StatefulWidget {
  const _AvatarWidget({
    this.imageId,
    required this.onChange,
  });

  final int? imageId;
  final void Function(int? imageId) onChange;

  @override
  State<_AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<_AvatarWidget> {
  final ImageRequest _imageRequest = ImageRequest();
  ImageModel? image = ImageModel();

  @override
  void initState() {
    // bytesImage = const Base64Decoder().convert(widget.base64);
    _loadImage(widget.imageId);
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
                child: image?.data != null && image?.data != ""
                    ? Image.memory(
                        const Base64Decoder().convert(image?.data ?? ''),
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
                        onPressed: () => _trashPhoto(widget.imageId),
                        icon: Icon(Icons.delete_outline, color: BC.white)),
                    IconButton(
                        splashRadius: 10,
                        onPressed: () => _downloadPhoto(widget.imageId),
                        icon: Icon(Icons.download, color: BC.white)),
                    IconButton(
                        splashRadius: 10,
                        onPressed: () => _uploadPhoto(widget.imageId),
                        icon: Icon(Icons.change_circle_outlined,
                            color: BC.white)),
                  ]),
            )
          ],
        ));
  }

  Future<void> _loadImage(int? imageId) async {
    if (imageId == null) return;
    final res = await _imageRequest.get(imageId.toString());
    if (res == null) return;
    setState(() {
      image = res;
    });
  }

  _trashPhoto(int? imageId) async {
    if (imageId == null) return;
    final image = await _imageRequest.remove(widget.imageId.toString());
    if (image?.id == widget.imageId) {
      setState(() {
        this.image = ImageModel();
      });
    }
  }

  _downloadPhoto(int? imageId) async {
    if (imageId == null) return;
    final image = await _imageRequest.get(widget.imageId.toString());
    final bytesImage = const Base64Decoder().convert(image?.data ?? '');

    if (bytesImage.isNotEmpty) {
      await WebImageDownloader.downloadImageFromUInt8List(
          uInt8List: bytesImage);
    }
  }

  _uploadPhoto(int? imageId) async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    var mime = lookupMimeType('', headerBytes: bytesFromPicker) ?? '';
    var extension = '.${extensionFromMime(mime)}';

    if (bytesFromPicker == null) return;
    final data = base64.encode(bytesFromPicker);

    ImageModel? imageRes;

    if (imageId != null) {
      final newImage = ImageModel(
        data: data,
        extension: extension,
        user_id: image?.user_id,
        time_create: image?.time_create,
        id: image?.id,
      );
      imageRes = await _imageRequest.change(newImage);
    } else {
      imageRes = await _imageRequest.create(ImageRequestModel(
        data: data,
        extension: extension,
      ));
    }

    widget.onChange(imageRes?.id);

    setState(() {
      image = imageRes;
    });
  }
}

class FieldModel {
  String? title;
  TextEditingController? controller;
  int? imageId;
  bool? value;
  List<dynamic>? values;
  dynamic enumValue;
  FieldType? type;
  bool? enable;
  bool required;

  FieldModel(
      {this.title = '',
      this.controller,
      this.imageId,
      this.value,
      this.values,
      this.enumValue,
      this.type = FieldType.text,
      this.enable = true,
      this.required = false}) {
    if (type == FieldType.text && controller == null) {
      controller = TextEditingController();
    }
  }
}

enum FieldType {
  checkbox,
  text,
  bigText,
  email,
  avatar,
  dropdown,
  enums,
  dateTime
}
