import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/screens/main_page/bloc.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/widgets/custom_auto_tabs_scaffold.dart';
import 'package:totalis_admin/widgets/custom_side_bar.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainBloc _bloc = MainBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) {
          return CustomAutoTabsScaffold(
            routes: const [
              AdminsRoute(),
              UsersRoute(),
              CategoriesRoute(),
              UserCategoriesRoute(),
              CoachesRoute(),
              CheckInsRoute(),
              RecommendationRoute(),
              VariableRoute(),
              MessageRoute(),
            ],
            bodyBuilder: (_, tabsRouter) {
              return CustomSideBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
              );
            },
          );
        });
  }
}
