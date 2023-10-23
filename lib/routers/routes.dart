import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/screens/auth_page/page.dart';
import 'package:totalis_admin/screens/main_page/page.dart';
import 'package:totalis_admin/screens/main_page/screens/admins_page/page.dart';
import 'package:totalis_admin/widgets/chage_page.dart';
import 'package:totalis_admin/screens/main_page/screens/categories_page/page.dart';
import 'package:totalis_admin/screens/main_page/screens/check_ins/page.dart';
import 'package:totalis_admin/screens/main_page/screens/coaches/page.dart';
import 'package:totalis_admin/screens/main_page/screens/recommendation/page.dart';
import 'package:totalis_admin/screens/main_page/screens/user_categories_page/page.dart';
import 'package:totalis_admin/screens/main_page/screens/users_page/page.dart';
import 'package:totalis_admin/screens/main_page/screens/variable/page.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/', page: LoginRoute.page),
    AutoRoute(path: '/main', page: MainRoute.page, children: [
      AutoRoute(path: 'admins', page: AdminsRoute.page),
      AutoRoute(path: 'users', page: UsersRoute.page),
      AutoRoute(path: 'categories', page: CategoriesRoute.page),
      AutoRoute(path: 'user-categories', page: UserCategoriesRoute.page),
      AutoRoute(path: 'coaches', page: CoachesRoute.page),
      AutoRoute(path: 'check-ins', page: CheckInsRoute.page),
      AutoRoute(path: 'recommendations', page: RecommendationRoute.page),
      AutoRoute(path: 'variables', page: VariableRoute.page),
      AutoRoute(path: 'messages', page: LoginRoute.page),
    ]),
    AutoRoute(path: '/change', page: ChangeRoute.page),
  ];
}

// dart run build_runner watch
// dart run build_runner build
