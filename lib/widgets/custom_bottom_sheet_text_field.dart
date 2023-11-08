import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:totalis_admin/generated/assets.gen.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/widgets/chage_page.dart';
import 'dart:js' as js;

class CustomBottomSheetTextField {
  show(BuildContext context, FieldModel? field) {
    final themeData = Theme.of(context);
    return showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.6),
        // Background color
        barrierDismissible: false,
        barrierLabel: 'Dialog',
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, __, ___) {
          return Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 32, right: 32),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: BC.green,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(6),
                                topLeft: Radius.circular(6)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(field?.title ?? '',
                              style: BS.light14.apply(color: BC.white)),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: BC.green,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(6),
                                  topLeft: Radius.circular(6)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Icon(Icons.close, color: BC.white, size: 24),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(32, 72, 32, 32),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      color: BC.white,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(6),
                          bottomLeft: Radius.circular(6))),
                  child: FormBuilderTextField(
                    onChanged: (value) =>
                        js.context.callMethod('enableSpellCheck'),
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    controller: field?.controller,
                    enabled: field?.enable ?? true,
                    name: field?.title ?? '',
                    style: BS.reg16.apply(color: BC.black),
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: BC.black,
                    decoration: InputDecoration(
                      labelText: field?.title ?? '',
                      hintText: field?.title ?? '',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // validator: (widget.field?.required ?? false)
                    //     ? FormBuilderValidators.required()
                    //     : null,
                  ),
                ),
                Positioned(
                    right: 32,
                    bottom: 32,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: BC.green, borderRadius: BRadius.r6),
                          child: Transform.rotate(
                              angle: 180 * 3.14 / 180,
                              child: Assets.openBigTextfield.svg())),
                    )),
              ],
            ),
          );
        });
  }
}
