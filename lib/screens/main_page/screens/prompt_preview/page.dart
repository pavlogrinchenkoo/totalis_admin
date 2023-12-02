import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:totalis_admin/generated/assets.gen.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user/bloc.dart'
    as ub;
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user_category/bloc.dart'
    as ucb;
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/message/bloc.dart'
    as mb;
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/new_checkin/bloc.dart'
    as ckb;
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/app_bar_back_button.dart';
import 'package:totalis_admin/widgets/chage_page.dart';
import 'package:totalis_admin/widgets/custom_bottom_sheet_text_field.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';

import 'bloc.dart';
import 'widgets/user/widget.dart';
import 'widgets/user_category/widget.dart';

@RoutePage()
class PromptPreviewPage extends StatefulWidget {
  const PromptPreviewPage(
      {this.field, this.categoryId, this.onSave, super.key});

  final FieldModel? field;
  final int? categoryId;
  final void Function()? onSave;

  @override
  State<PromptPreviewPage> createState() => _PromptPreviewPageState();
}

class _PromptPreviewPageState extends State<PromptPreviewPage> {
  final PromptPreviewBloc _bloc = PromptPreviewBloc();
  final ub.UserSearchBloc userBloc = ub.UserSearchBloc();
  final ucb.UserCategorySearchBloc userCategoryBloc =
      ucb.UserCategorySearchBloc();
  final mb.MessagesSearchBloc messagesBloc = mb.MessagesSearchBloc();
  final ckb.CheckinsSearchBloc checkinsBloc = ckb.CheckinsSearchBloc();

  @override
  void initState() {
    _bloc.init();
    userBloc.init();
    // userCategoryBloc.init();
    messagesBloc.init();
    // checkinsBloc.init();
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const AppBarBackButton(),
                        Space.w16,
                        Text(widget.field?.title ?? '',
                            style: BS.med20.apply(color: BC.white))
                      ],
                    ),
                    Space.h24,
                    Row(children: [
                      if (widget.field?.title == 'Prompt' ||
                          widget.field?.title == 'Prompt checkin proposal' ||
                          widget.field?.title == 'Prompt checkin')
                        UserSearchWidget(bloc: userBloc),
                      // if (widget.field?.title == 'Prompt' ||
                      //     widget.field?.title == 'Prompt checkin proposal')
                      //   UserCategorySearchWidget(
                      //       bloc: userCategoryBloc, userBloc: userBloc),
                      // if (widget.field?.title == 'Prompt' ||
                      //     widget.field?.title == 'Prompt checkin')
                      //   Expanded(
                      //     child: Row(
                      //       children: [
                      //         MessagesSearchWidget(bloc: messagesBloc),
                      //         Space.w22,
                      //       ],
                      //     ),
                      //   ),
                      // if (widget.field?.title == 'Prompt checkin')
                      //   CheckinsSearchWidget(
                      //       bloc: checkinsBloc, userBloc: userBloc),
                    ]),
                    Space.h24,
                    Stack(
                      children: [
                        FormBuilderTextField(
                          // onChanged: (value) => js.context.callMethod('enableSpellCheck'),
                          minLines: 10,
                          maxLines: 10,
                          controller: widget.field?.controller,
                          name: widget.field?.title ?? '',
                          decoration: InputDecoration(
                            labelText: widget.field?.title ?? '',
                            hintText: widget.field?.title ?? '',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          // validator: (widget.field?.required ?? false)
                          //     ? FormBuilderValidators.required()
                          //     : null,
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
                                      color: BC.green,
                                      borderRadius: BRadius.r6),
                                  child: Assets.openBigTextfield.svg()),
                            )),
                      ],
                    ),
                    Space.h24,
                    Row(
                      children: [
                        if (state.loadingPreview)
                          const CustomProgressIndicator()
                        else
                          ElevatedButton(
                              style: themeData
                                  .extension<AppButtonTheme>()!
                                  .primaryElevated,
                              onPressed: () => _bloc.preview(context, userBloc,
                                  widget.categoryId, widget.field),
                              child: const Text('Preview')),
                        Space.w52,
                        ElevatedButton(
                            style: themeData
                                .extension<AppButtonTheme>()!
                                .primaryElevated,
                            onPressed: () {
                              widget.onSave?.call();
                              _bloc.onSave();
                            },
                            child: Text(state.saved ? 'Saved' : 'Save prompt')),
                      ],
                    ),
                    Space.h24,
                    Stack(
                      children: [
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
                        Positioned(
                            right: 1,
                            bottom: 1,
                            child: InkWell(
                              onTap: () => CustomBottomSheetTextField().show(
                                  context,
                                  FieldModel(
                                      controller: _bloc.controller,
                                      title: 'Response',
                                      enable: true)),
                              child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: BC.green,
                                      borderRadius: BRadius.r6),
                                  child: Assets.openBigTextfield.svg()),
                            )),
                      ],
                    ),
                    Space.h24,
                    FormBuilderTextField(
                      // onChanged: (value) => js.context.callMethod('enableSpellCheck'),
                      minLines: 1,
                      maxLines: 10,
                      controller: _bloc.controllerMessage,
                      name: 'Message',
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        hintText: 'Message',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    Space.h24,
                    if (state.loadingLlm)
                      const CustomProgressIndicator()
                    else
                      ElevatedButton(
                          style: themeData
                              .extension<AppButtonTheme>()!
                              .primaryElevated,
                          onPressed: () =>
                              _bloc.previewLlm(context, _bloc.controller.text),
                          child: const Text('Preview LLM')),
                    Space.h24,
                    FormBuilderTextField(
                      // onChanged: (value) => js.context.callMethod('enableSpellCheck'),
                      minLines: 10,
                      maxLines: 10,
                      controller: _bloc.controllerLlm,
                      name: 'Response LLM',
                      decoration: const InputDecoration(
                        labelText: 'Response LLM',
                        hintText: 'Response LLM',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    )
                  ],
                ),
              ),
            ));
          }
        });
  }
}

class PromptPreviewBottomSheet {
  show(BuildContext context, FieldModel? field, int? categoryId,
      void Function()? onSave) {
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
            child: PromptPreviewPage(
                field: field, categoryId: categoryId, onSave: onSave),
          );
        });
  }
}
