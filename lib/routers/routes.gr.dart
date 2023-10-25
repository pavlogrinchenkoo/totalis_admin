// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPage(
          reLogin: args.reLogin,
          key: args.key,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    CheckInsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CheckInsPage(),
      );
    },
    RecommendationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RecommendationPage(),
      );
    },
    VariableRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const VariablePage(),
      );
    },
    CoachesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CoachesPage(),
      );
    },
    MessageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MessagePage(),
      );
    },
    AdminsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AdminsPage(),
      );
    },
    UsersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UsersPage(),
      );
    },
    UserCategoriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserCategoriesPage(),
      );
    },
    CategoriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoriesPage(),
      );
    },
    ChangeRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeRouteArgs>(
          orElse: () => const ChangeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangePage(
          fields: args.fields,
          title: args.title,
          onSave: args.onSave,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    bool reLogin = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            reLogin: reLogin,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.reLogin = false,
    this.key,
  });

  final bool reLogin;

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{reLogin: $reLogin, key: $key}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CheckInsPage]
class CheckInsRoute extends PageRouteInfo<void> {
  const CheckInsRoute({List<PageRouteInfo>? children})
      : super(
          CheckInsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckInsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecommendationPage]
class RecommendationRoute extends PageRouteInfo<void> {
  const RecommendationRoute({List<PageRouteInfo>? children})
      : super(
          RecommendationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecommendationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [VariablePage]
class VariableRoute extends PageRouteInfo<void> {
  const VariableRoute({List<PageRouteInfo>? children})
      : super(
          VariableRoute.name,
          initialChildren: children,
        );

  static const String name = 'VariableRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CoachesPage]
class CoachesRoute extends PageRouteInfo<void> {
  const CoachesRoute({List<PageRouteInfo>? children})
      : super(
          CoachesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CoachesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MessagePage]
class MessageRoute extends PageRouteInfo<void> {
  const MessageRoute({List<PageRouteInfo>? children})
      : super(
          MessageRoute.name,
          initialChildren: children,
        );

  static const String name = 'MessageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AdminsPage]
class AdminsRoute extends PageRouteInfo<void> {
  const AdminsRoute({List<PageRouteInfo>? children})
      : super(
          AdminsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UsersPage]
class UsersRoute extends PageRouteInfo<void> {
  const UsersRoute({List<PageRouteInfo>? children})
      : super(
          UsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserCategoriesPage]
class UserCategoriesRoute extends PageRouteInfo<void> {
  const UserCategoriesRoute({List<PageRouteInfo>? children})
      : super(
          UserCategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserCategoriesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoriesPage]
class CategoriesRoute extends PageRouteInfo<void> {
  const CategoriesRoute({List<PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangePage]
class ChangeRoute extends PageRouteInfo<ChangeRouteArgs> {
  ChangeRoute({
    List<FieldModel>? fields,
    String? title,
    void Function()? onSave,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ChangeRoute.name,
          args: ChangeRouteArgs(
            fields: fields,
            title: title,
            onSave: onSave,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeRoute';

  static const PageInfo<ChangeRouteArgs> page = PageInfo<ChangeRouteArgs>(name);
}

class ChangeRouteArgs {
  const ChangeRouteArgs({
    this.fields,
    this.title,
    this.onSave,
    this.key,
  });

  final List<FieldModel>? fields;

  final String? title;

  final void Function()? onSave;

  final Key? key;

  @override
  String toString() {
    return 'ChangeRouteArgs{fields: $fields, title: $title, onSave: $onSave, key: $key}';
  }
}
