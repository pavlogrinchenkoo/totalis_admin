import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/users_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_checkbox.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_circle_avatar.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';
import 'package:totalis_admin/widgets/custom_sheet_header_widget.dart';
import 'package:totalis_admin/widgets/custom_sheet_widget.dart';
import 'package:totalis_admin/widgets/sheets_text.dart';

@RoutePage()
class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final UsersBloc _bloc = UsersBloc();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _bloc.init();
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
    final titles = ['Id', 'Name', 'Tester'];

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSheetHeaderWidget(
                      title: 'Users',
                      onSave: () => _bloc.openChange(context, UserModel())),
                  Space.h24,
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        Row(
                          children: [
                            CustomSheetWidget(
                              columns: <DataColumn>[
                                for (final title in titles)
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(title),
                                    ),
                                  ),
                              ],
                              rows: <DataRow>[
                                for (final item in state.users)
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(InkWell(
                                          borderRadius: BRadius.r6,
                                          onTap: () =>
                                              _bloc.openChange(context, item),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SheetText(text: item?.id),
                                            ],
                                          ))),
                                      DataCell(Row(
                                        children: [
                                          CustomCircle(imageId: item?.image_id),
                                          Space.w16,
                                          SheetText(
                                              text:
                                                  '${item?.first_name ?? ''} ${item?.last_name ?? ''}'),
                                        ],
                                      )),
                                      DataCell(CustomCheckbox(
                                          value: item?.is_tester,
                                          onChanged: (isTester) => _bloc
                                              .changeIsTester(item, isTester))),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
          }
        });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      _bloc.uploadItems();
    }
  }
}
