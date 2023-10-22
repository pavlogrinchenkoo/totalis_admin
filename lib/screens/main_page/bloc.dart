import 'package:auto_route/auto_route.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

class MainBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  MainBloc() {
    setState(ScreenState());
  }

  void setTabsRouter(TabsRouter tabsRouter) {
    setState(currentState.copyWith(tabsRouter: tabsRouter));
  }
}

class ScreenState {
  final bool loading;
  final TabsRouter? tabsRouter;

  ScreenState({this.loading = false, this.tabsRouter});

  ScreenState copyWith({bool? loading, TabsRouter? tabsRouter}) {
    return ScreenState(
        loading: loading ?? this.loading,
        tabsRouter: tabsRouter ?? this.tabsRouter);
  }
}
