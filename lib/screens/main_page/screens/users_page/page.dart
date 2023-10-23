import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/user/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/users_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';

import 'widgets/custom_sheets_widget.dart';

@RoutePage()
class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final UsersBloc _bloc = UsersBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          if (state.loading && state.users.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.only(top: 80, left: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Users', style: BS.sb32),
                  Space.h24,
                  CustomSheetsWidget(
                      onChangeIsTester: (UserModel? item, bool isTester) =>
                          _bloc.changeIsTester(item, isTester),
                      items: state.users,
                      openChange: (item) => _bloc.openChange(context, item)),
                ],
              ),
            ));
          }
        });
  }
}
