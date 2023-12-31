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
    AdminsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AdminsPage(),
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
          fieldsInGroups: args.fieldsInGroups,
          title: args.title,
          onSave: args.onSave,
          onSavePrompt: args.onSavePrompt,
          onDelete: args.onDelete,
          widget: args.widget,
          category: args.category,
          key: args.key,
        ),
      );
    },
    CheckInsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CheckInsPage(),
      );
    },
    CoachesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CoachesPage(),
      );
    },
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
    MessageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MessagePage(),
      );
    },
    ModelsChatGptRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ModelsChatGptPage(),
      );
    },
    PromptPreviewRoute.name: (routeData) {
      final args = routeData.argsAs<PromptPreviewRouteArgs>(
          orElse: () => const PromptPreviewRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PromptPreviewPage(
          field: args.field,
          categoryId: args.categoryId,
          onSave: args.onSave,
          key: args.key,
        ),
      );
    },
    RecommendationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RecommendationPage(),
      );
    },
    SystemRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SystemPage(),
      );
    },
    UserCategoriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserCategoriesPage(),
      );
    },
    UsersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UsersPage(),
      );
    },
    VariableRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const VariablePage(),
      );
    },
  };
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
    List<List<FieldModel>>? fieldsInGroups,
    String? title,
    void Function()? onSave,
    void Function()? onSavePrompt,
    void Function()? onDelete,
    Widget? widget,
    CategoryModel? category,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ChangeRoute.name,
          args: ChangeRouteArgs(
            fields: fields,
            fieldsInGroups: fieldsInGroups,
            title: title,
            onSave: onSave,
            onSavePrompt: onSavePrompt,
            onDelete: onDelete,
            widget: widget,
            category: category,
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
    this.fieldsInGroups,
    this.title,
    this.onSave,
    this.onSavePrompt,
    this.onDelete,
    this.widget,
    this.category,
    this.key,
  });

  final List<FieldModel>? fields;

  final List<List<FieldModel>>? fieldsInGroups;

  final String? title;

  final void Function()? onSave;

  final void Function()? onSavePrompt;

  final void Function()? onDelete;

  final Widget? widget;

  final CategoryModel? category;

  final Key? key;

  @override
  String toString() {
    return 'ChangeRouteArgs{fields: $fields, fieldsInGroups: $fieldsInGroups, title: $title, onSave: $onSave, onSavePrompt: $onSavePrompt, onDelete: $onDelete, widget: $widget, category: $category, key: $key}';
  }
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
/// [ModelsChatGptPage]
class ModelsChatGptRoute extends PageRouteInfo<void> {
  const ModelsChatGptRoute({List<PageRouteInfo>? children})
      : super(
          ModelsChatGptRoute.name,
          initialChildren: children,
        );

  static const String name = 'ModelsChatGptRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PromptPreviewPage]
class PromptPreviewRoute extends PageRouteInfo<PromptPreviewRouteArgs> {
  PromptPreviewRoute({
    FieldModel? field,
    int? categoryId,
    void Function()? onSave,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          PromptPreviewRoute.name,
          args: PromptPreviewRouteArgs(
            field: field,
            categoryId: categoryId,
            onSave: onSave,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PromptPreviewRoute';

  static const PageInfo<PromptPreviewRouteArgs> page =
      PageInfo<PromptPreviewRouteArgs>(name);
}

class PromptPreviewRouteArgs {
  const PromptPreviewRouteArgs({
    this.field,
    this.categoryId,
    this.onSave,
    this.key,
  });

  final FieldModel? field;

  final int? categoryId;

  final void Function()? onSave;

  final Key? key;

  @override
  String toString() {
    return 'PromptPreviewRouteArgs{field: $field, categoryId: $categoryId, onSave: $onSave, key: $key}';
  }
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
/// [SystemPage]
class SystemRoute extends PageRouteInfo<void> {
  const SystemRoute({List<PageRouteInfo>? children})
      : super(
          SystemRoute.name,
          initialChildren: children,
        );

  static const String name = 'SystemRoute';

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
