import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:totalis_admin/api/categories/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/prompt_preview/widgets/user/bloc.dart'
    as ub;
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';

import 'bloc.dart';

class UserCategorySearchWidget extends StatefulWidget {
  const UserCategorySearchWidget({
    required this.bloc,
    required this.userBloc,
    this.onChange,
    this.onClear,
    super.key,
  });

  final UserCategorySearchBloc bloc;
  final ub.UserSearchBloc userBloc;
  final void Function()? onChange;
  final void Function()? onClear;

  @override
  State<UserCategorySearchWidget> createState() =>
      _UserCategorySearchWidgetState();
}

class _UserCategorySearchWidgetState extends State<UserCategorySearchWidget> {
  final TextEditingController controller = TextEditingController();

  // List<DropdownMenuItem<String>> fields =
  //     ['id', 'category_id', 'user_id'].map((e) {
  //   return DropdownMenuItem(
  //       value: e, child: Text(e.toString().split('.').last));
  // }).toList();
  // String? field;
  // final ScrollController _scrollController = ScrollController();
  //
  // @override
  // void initState() {
  //   _scrollController.addListener(_scrollListener);
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _scrollController.removeListener(_scrollListener);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: widget.userBloc,
        builder: (context, ub.ScreenState ubState) {
          return CustomStreamBuilder<ScreenState>(
              bloc: widget.bloc,
              builder: (context, ScreenState state) {
                if (state.selectedUser?.id != ubState.selectedUser?.id) {
                  widget.bloc
                      .setUser(ubState.selectedUser, onClear: widget.onClear);
                }
                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FormBuilderDropdown(
                                dropdownColor: BC.white,
                                style: BS.med14.apply(color: BC.black),
                                enabled: state.categories.isNotEmpty,
                                name: state.categories.isNotEmpty
                                    ? 'Select categories'
                                    : 'No categories found',
                                decoration: InputDecoration(
                                  labelText: state.categories.isNotEmpty
                                      ? 'Select categories'
                                      : 'No categories found',
                                  border: const OutlineInputBorder(),
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                ),
                                focusColor: Colors.transparent,
                                initialValue: state.categories.isNotEmpty
                                    ? state.categories.first
                                    : null,
                                onChanged: (value) {
                                  widget.bloc.setCategory(
                                      value as CategoryModel?,
                                      state.userCategories);
                                  if (widget.onChange != null) {
                                    widget.onChange!();
                                  }
                                },
                                items: state.categories.isNotEmpty
                                    ? state.categories.map((e) {
                                        return DropdownMenuItem(
                                            value: e,
                                            child: Text(e?.name ?? ''));
                                      }).toList()
                                    : []),
                          ),
                          // Space.w16,
                          // Expanded(
                          //   flex: 2,
                          //   child: FormBuilderTextField(
                          //     onChanged: (value) =>
                          //         value == '' ? widget.bloc.searchUser(null) : null,
                          //     controller: controller,
                          //     name: 'User search',
                          //     decoration: const InputDecoration(
                          //       labelText: 'User search',
                          //       hintText: 'User search',
                          //       floatingLabelBehavior: FloatingLabelBehavior.always,
                          //     ),
                          //   ),
                          // ),
                          // Space.w16,
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
                      // SizedBox(
                      //   height: 400,
                      //   child: ListView(shrinkWrap: true, children: [
                      //     for (final item in state.items)
                      //       CheckItem(
                      //           text:
                      //               '${item?.id}: category_id: ${item?.category_id} user_id: ${item?.user_id}',
                      //           onTap: () => widget.bloc.selectUser(item),
                      //           isSelected: state.selectedItem?.id == item?.id),
                      //   ]),
                      // ),
                    ],
                  ),
                );
              });
        });
  }

// void _scrollListener() {
//   if (_scrollController.position.extentAfter < 500) {
//     widget.bloc.uploadItems();
//   }
// }
}
