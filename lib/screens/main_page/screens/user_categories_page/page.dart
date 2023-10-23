import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/api/user_categories/dto.dart';
import 'package:totalis_admin/screens/main_page/screens/user_categories_page/bloc.dart';
import 'package:totalis_admin/style.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/utils/spaces.dart';
import 'package:totalis_admin/widgets/custom_buttom.dart';
import 'package:totalis_admin/widgets/custom_progress_indicator.dart';

import 'widgets/custom_sheets_widget.dart';

@RoutePage()
class UserCategoriesPage extends StatefulWidget {
  const UserCategoriesPage({super.key});

  @override
  State<UserCategoriesPage> createState() => _UserCategoriesPageState();
}

class _UserCategoriesPageState extends State<UserCategoriesPage> {
  final UserCategoriesBloc _bloc = UserCategoriesBloc();

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
          if (state.loading && state.userCategories.isEmpty) {
            return const CustomProgressIndicator();
          } else {
            return Scaffold(
                body: Container(
              padding: const EdgeInsets.only(top: 80, left: 80, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text('User categories', style: BS.sb32),
                    Space.w52,
                    CustomButton(
                        title: 'New user category',
                        onTap: () =>
                            _bloc.openChange(context, UserCategoryModel())),
                  ]),
                  Space.h24,
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CustomSheetsWidget(
                            onChangeIsFavorite:
                                (UserCategoryModel? item, bool value) =>
                                    _bloc.changeIsFavorite(item, value),
                            items: state.userCategories,
                            openChange: (item) =>
                                _bloc.openChange(context, item)),
                      ],
                    ),
                  )
                ],
              ),
            ));
          }
        });
  }
}
