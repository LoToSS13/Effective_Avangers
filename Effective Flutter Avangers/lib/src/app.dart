import 'package:effective_avangers/src/screens/hero_detail_screen.dart';
import 'package:effective_avangers/src/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constant/main_navigation_route_name.dart';
import 'models/hero_info_args.dart';

class App extends ConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Avangers',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
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
