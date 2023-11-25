import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/checkins/widget.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/message/widget.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user/user_search_bloc.dart'
    as ub;
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user_category/user_category_search_bloc.dart'
    as ucb;
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/message/bloc.dart'
    as mb;
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/checkins/bloc.dart'
    as ckb;
import 'package:totalis_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/app_bar_back_button.dart';
import 'package:totalis_admin/widgets/chage_page.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';

import 'bloc.dart';
import 'widgets/user/user_search.dart';
import 'widgets/user_category/user_category_search.dart';

@RoutePage()
class PromptPreviewPage extends StatefulWidget {
  const PromptPreviewPage(
      {this.field,
      this.needUser = false,
      this.needUserCategory = false,
      this.needMessages = false,
      this.needCheckins = false,
      this.isPrompt = false,
      this.isPromptCheckinProposal = false,
      this.isPromptCheckin = false,
      super.key});

  final FieldModel? field;
  final bool needUser;
  final bool needUserCategory;
  final bool needMessages;
  final bool needCheckins;
  final bool isPrompt;
  final bool isPromptCheckinProposal;
  final bool isPromptCheckin;

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
    userCategoryBloc.init();
    messagesBloc.init();
    checkinsBloc.init();
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
                    const AppBarBackButton(),
                    Space.h24,
                    SizedBox(
                      height: 500,
                      child: Row(children: [
                        if (widget.field?.title == 'Prompt' ||
                            widget.field?.title == 'Prompt checkin proposal' ||
                            widget.field?.title == 'Prompt checkin')
                          UserSearchWidget(bloc: userBloc),
                        if (widget.field?.title == 'Prompt' ||
                            widget.field?.title == 'Prompt checkin proposal')
                          UserCategorySearchWidget(bloc: userCategoryBloc),
                        if (widget.field?.title == 'Prompt' ||
                            widget.field?.title == 'Prompt checkin')
                          MessagesSearchWidget(bloc: messagesBloc),
                        if (widget.field?.title == 'Prompt checkin')
                          CheckinsSearchWidget(bloc: checkinsBloc)
                      ]),
                    ),
                    Space.h24,
                    ElevatedButton(
                        style: themeData
                            .extension<AppButtonTheme>()!
                            .primaryElevated,
                        onPressed: () => _bloc.preview(
                          context,
                            widget.field,
                            userCategoryBloc,
                            messagesBloc,
                            checkinsBloc,
                            userBloc),
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
                    Space.h24,
                    ElevatedButton(
                        style: themeData
                            .extension<AppButtonTheme>()!
                            .primaryElevated,
                        onPressed: () =>
                            _bloc.previewLlc(context, _bloc.controller.text),
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
