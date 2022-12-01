import 'package:effective_avangers/main.dart';
import 'package:effective_avangers/src/constant/colors.dart';
import 'package:effective_avangers/src/screens/hero_detail_screen.dart';
import 'package:effective_avangers/src/screens/main_screen.dart';
import 'package:effective_avangers/src/widgets/loading_progress_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constant/main_navigation_route_name.dart';
import 'models/hero_info_args.dart';

final characterInfoProvider = FutureProvider((ref) async {
  final charactersRepository = ref.watch(charactersRepositoryProvider);

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    final String characterID = initialMessage.data['character_id'];
    final characterInfo =
        await charactersRepository.getExactCharacter(characterID);
    return characterInfo;
  }
  return null;
});

class App extends ConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialHeroInfo = ref.watch(characterInfoProvider);
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
      home: initialHeroInfo.when(data: ((data) {
        return HeroDetailScreen(heroInfo: data);
      }), error: (err, stackTrace) {
        return const MainScreen();
      }, loading: (() {
        return const Scaffold(
          backgroundColor: mainBackgroundColor,
          body: Center(child: LoadingProgressIndicator()),
        );
      })),
    );
  }
}
