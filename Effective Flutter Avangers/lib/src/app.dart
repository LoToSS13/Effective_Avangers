import 'package:effective_avangers/src/constant/colors.dart';
import 'package:effective_avangers/src/screens/hero_detail_screen.dart';
import 'package:effective_avangers/src/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constant/main_navigation_route_name.dart';
import 'models/hero_info_args.dart';
import 'network/push_notification_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends ConsumerStatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AppState();
}

class AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    PushNotificationService.initialise(ref);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ru', ''),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Avangers',
        theme: ThemeData(
          primaryColor: marvelColor,
        ),
        darkTheme: ThemeData(
          primaryColor: marvelColor,
        ),
        themeMode: ThemeMode.system,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case MainNavigationRouteName.detailed:
                  {
                    final args = settings.arguments as HeroInfoArgs;
                    return HeroDetailScreen(heroInfo: args.heroInfo);
                  }
                case MainNavigationRouteName.main:
                  {
                    return const MainScreen();
                  }
                default:
                  return Scaffold(appBar: AppBar(), body: const Center());
              }
            },
          );
        },
        home: const MainScreen());
  }
}
