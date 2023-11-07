import 'package:alice/alice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:totalis_admin/firebase_options.dart';
import 'package:totalis_admin/generated/l10n.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/theme/themes.dart';
import 'package:totalis_admin/utils/localization.dart';

Alice alice = Alice();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext buildContext) {
    alice.setNavigatorKey(_appRouter.navigatorKey);
    return ChangeNotifierProvider<LanguageService>(create: (context) {
      return LanguageService();
    }, builder: (context, child) {
      var service = context.watch<LanguageService>();
      final l = service.locale;
      if (l != _currentLocale) {
        _currentLocale = l;
        _rebuildAllChildren(context);
      }
      return MaterialApp.router(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: l,
        themeMode: ThemeMode.light,
        theme: AppThemeData.instance.dark(),
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
      );
    });
  }
}

Locale _currentLocale = const Locale('en');

void _rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}
