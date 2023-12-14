import 'package:flutter/material.dart';
import 'package:totalis_admin/screens/main_page/screens/categories_page/bloc.dart';
import 'package:totalis_admin/screens/main_page/screens/user_categories_page/widgets/category/page.dart';
import 'package:totalis_admin/screens/main_page/screens/user_categories_page/widgets/user/page.dart';
import 'package:totalis_admin/screens/main_page/screens/users_page/bloc.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';

import 'bloc.dart' as cb;

class UserAndCategoryWidget extends StatefulWidget {
  const UserAndCategoryWidget({required this.userCategoryId, super.key});

  final int? userCategoryId;

  @override
  State<UserAndCategoryWidget> createState() => _UserAndCategoryWidgetState();
}

class _UserAndCategoryWidgetState extends State<UserAndCategoryWidget> {
  final cb.UserAndCategoryWidgetBloc _bloc = cb.UserAndCategoryWidgetBloc();
  final UsersBloc userBloc = UsersBloc();
  final CategoriesBloc categoryBloc = CategoriesBloc();

  @override
  void initState() {
    _bloc.init(widget.userCategoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, cb.ScreenState state) {
          if (!state.loading && state.userCategory != null) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 150),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserWidget(
                              userId: state.userCategory?.user_id,
                              onTap: (user) =>
                                  userBloc.openChange(context, user)),
                          CategoryWidget(
                              categoryId: state.userCategory?.category_id,
                              onTap: (category) =>
                                  categoryBloc.openChange(context, category)),
                        ]),
                  ),
                ),
              ],
            );
          } else {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('--'),
              ],
            );
          }
        });
  }
}
