import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/debouncer.dart';
import 'package:totalis_admin/utils/spaces.dart';

import '../check_items.dart';
import 'bloc.dart';

class UserSearchWidget extends StatefulWidget {
  const UserSearchWidget({required this.bloc, super.key});

  final UserSearchBloc bloc;

  @override
  State<UserSearchWidget> createState() => _UserSearchWidgetState();
}

class _UserSearchWidgetState extends State<UserSearchWidget> {
  final TextEditingController controller = TextEditingController();
  List<DropdownMenuItem<String>> fields =
      ['id', 'first_name', 'last_name', 'coach_id'].map((e) {
    return DropdownMenuItem(
        value: e, child: Text(e.toString().split('.').last));
  }).toList();
  String? field;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return CustomStreamBuilder(
        bloc: widget.bloc,
        builder: (context, ScreenState state) {
          return Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    // Expanded(
                    //   flex: 1,
                    //   child: FormBuilderDropdown(
                    //       name: 'Select field',
                    //       decoration: const InputDecoration(
                    //         labelText: 'Select field',
                    //         border: OutlineInputBorder(),
                    //         hoverColor: Colors.transparent,
                    //         focusColor: Colors.transparent,
                    //       ),
                    //       focusColor: Colors.transparent,
                    //       initialValue: fields.first.value,
                    //       onChanged: (String? value) => setState(() {
                    //             field = value;
                    //           }),
                    //       items: fields),
                    // ),
                    // Space.w16,
                    Expanded(
                      flex: 2,
                      child: FormBuilderTextField(
                        onChanged: (value) => _debouncer.run(() {
                          widget.bloc.searchUser(Filters(
                            field: 'id',
                            value: int.tryParse(value ?? ''),
                          ));
                        }),
                        controller: controller,
                        name: 'User id',
                        decoration: const InputDecoration(
                          labelText: 'User id',
                          hintText: 'User id',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    if (state.nothingFound == true ||
                        state.selectedUser != null)
                      Space.w16,
                      if (state.nothingFound)
                        const Text('Nothing found')
                      else
                        state.selectedUser != null
                            ? Text(
                                '${state.selectedUser?.id}: ${state.selectedUser?.first_name ?? ''} ${state.selectedUser?.last_name ?? ''}')
                            : const SizedBox(),
                    // ElevatedButton(
                    //     style: themeData
                    //         .extension<AppButtonTheme>()!
                    //         .primaryElevated,
                    //     onPressed: () => controller.text != ''
                    //         ? widget.bloc.searchUser(
                    //             Filters(
                    //                 field: field ?? fields.first.value ?? 'id',
                    //                 value: controller.text),
                    //           )
                    //         : null,
                    //     child: const Text('Search')),
                  ],
                ),
                // ListView(
                //     shrinkWrap: true,
                //     children: [
                //       for (final user in state.users)
                //         CheckItem(
                //             text:
                //                 '${user?.id}: ${user?.first_name} ${user?.last_name}',
                //             onTap: () => widget.bloc.selectUser(user),
                //             isSelected: state.selectedUser?.id == user?.id),
                //     ]),
              ],
            ),
          );
        });
  }
}
