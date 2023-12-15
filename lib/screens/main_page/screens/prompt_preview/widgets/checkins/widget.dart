import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:totalis_admin/api/filters/dto.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/theme/theme_extensions/app_button_theme.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';

import '../check_items.dart';
import 'bloc.dart';

class CheckinsSearchWidget extends StatefulWidget {
  const CheckinsSearchWidget({required this.bloc, super.key});

  final CheckinsSearchBloc bloc;

  @override
  State<CheckinsSearchWidget> createState() => _CheckinsSearchWidgetState();
}

class _CheckinsSearchWidgetState extends State<CheckinsSearchWidget> {
  final TextEditingController controller = TextEditingController();
  List<DropdownMenuItem<String>> fields =
      ['id', 'user_category_id', 'level'].map((e) {
    return DropdownMenuItem(
        value: e, child: Text(e.toString().split('.').last));
  }).toList();
  String? field;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return CustomStreamBuilder<ScreenState>(
        bloc: widget.bloc,
        builder: (context, ScreenState state) {
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
                          name: 'Select field',
                          decoration: const InputDecoration(
                            labelText: 'Select field',
                            border: OutlineInputBorder(),
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                          ),
                          focusColor: Colors.transparent,
                          initialValue: fields.first.value,
                          onChanged: (String? value) => setState(() {
                                field = value;
                              }),
                          items: fields),
                    ),
                    Space.w16,
                    Expanded(
                      flex: 2,
                      child: FormBuilderTextField(
                        onChanged: (value) =>
                            value == '' ? widget.bloc.searchUser(null) : null,
                        controller: controller,
                        name: 'User search',
                        style: BS.med14.apply(color: BC.black),
                        decoration: const InputDecoration(
                          labelText: 'User search',
                          hintText: 'User search',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    Space.w16,
                    ElevatedButton(
                        style: themeData
                            .extension<AppButtonTheme>()!
                            .primaryElevated,
                        onPressed: () => controller.text != ''
                            ? widget.bloc.searchUser(
                                Filters(
                                    field: field ?? fields.first.value ?? 'id',
                                    value: controller.text),
                              )
                            : null,
                        child: const Text('Search')),
                  ],
                ),
                SizedBox(
                  height: 400,
                  child: ListView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      children: [
                        for (final item in state.items)
                          CheckItem(
                              text:
                                  '${item?.id}: user_category_id: ${item?.user_category_id} level: ${item?.level}',
                              onTap: () => widget.bloc.selectUser(item),
                              isSelected: state.selectedItem?.id == item?.id),
                      ]),
                ),
              ],
            ),
          );
        });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      widget.bloc.uploadItems();
    }
  }
}
