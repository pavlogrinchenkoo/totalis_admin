import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:totalis_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/app_bar_back_button.dart';
import 'package:totalis_admin/widgets/chage_page.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';

import 'bloc.dart';
import 'widgets/check_items.dart';

@RoutePage()
class PromptPreviewPage extends StatefulWidget {
  const PromptPreviewPage({this.field, super.key});

  final FieldModel? field;

  @override
  State<PromptPreviewPage> createState() => _PromptPreviewPageState();
}

class _PromptPreviewPageState extends State<PromptPreviewPage> {
  final PromptPreviewBloc _bloc = PromptPreviewBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.users.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const AppBarBackButton(),
                  Space.h24,
                  Row(children: [
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            for (final user in state.users)
                              CheckItem(
                                  text:
                                      '${user?.id}: ${user?.first_name} ${user?.last_name}',
                                  onTap: () => _bloc.selectUser(user),
                                  isSelected:
                                      state.selectedUser?.id == user?.id),
                          ]),
                    )
                    // Expanded(
                    //   child: ListView(
                    //       shrinkWrap: true,
                    //       physics: const NeverScrollableScrollPhysics(),
                    //       children: [
                    //         for (final category in state.categories)
                    //           CheckItem(
                    //               text:
                    //               '${category?.id}: ${category?.name}',
                    //               onTap: () => _bloc.selectCategory(category),
                    //               isSelected: state.selectedCategory?.id == category?.id),
                    //       ]),
                    // ),
                  ]),
                  Space.h24,
                  ElevatedButton(
                      style: themeData
                          .extension<AppButtonTheme>()!
                          .primaryElevated,
                      onPressed: () => _bloc.preview(widget.field),
                      child: const Text('Preview')),
                  Space.h24,
                  FormBuilderTextField(
                    // onChanged: (value) => js.context.callMethod('enableSpellCheck'),
                    minLines: 10,
                    maxLines: 10,
                    controller: _bloc.controller,
                    name: 'Response',
                    decoration: const InputDecoration(
                      labelText: 'Response',
                      hintText: 'Response',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // validator: (widget.field?.required ?? false)
                    //     ? FormBuilderValidators.required()
                    //     : null,
                  ),
                ],
              ),
            ));
          }
        });
  }
}

class PromptPreviewBottomSheet {
  show(
    BuildContext context,
    FieldModel? field,
  ) {
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
            child: PromptPreviewPage(field: field),
          );
        });
  }
}
