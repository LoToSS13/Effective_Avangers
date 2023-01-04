import 'package:effective_avangers/src/database/hero_database.dart';
import 'package:effective_avangers/src/models/hero_info_model.dart';
import 'package:effective_avangers/src/widgets/background_triangle_painter.dart';
import 'package:effective_avangers/src/widgets/error_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:drift/drift.dart' as drift;

import '../../main.dart';
import '../constant/colors.dart';
import '../constant/main_navigation_route_name.dart';
import '../models/hero_info_args.dart';
import '../network/characters_repository.dart';
import '../widgets/logo_widget.dart';
import '../widgets/loading_progress_indicator.dart';
import '../widgets/swiper_widget.dart';

final charactersInfosProvider = FutureProvider((ref) async {
  late List<HeroInfoModel>? infos;

  try {
    infos = await ref.watch(networkCharactersProvider);
    return infos;
  } on Exception {
    final infos = await ref.watch(dataBaseCharactersProvider);
    return infos;
  }
});

final networkCharactersProvider = Provider((ref) async {
  try {
    final charactersRepository = ref.watch(charactersRepositoryProvider);
    final infos = await charactersRepository.getCharacters();
    final heroDatabase = ref.watch(heroDataBaseProvider);

    for (HeroInfoModel item in infos) {
      heroDatabase.insertHeroInfo(HeroInfoCompanion(
          id: drift.Value(item.id),
          name: drift.Value(item.name),
          description: drift.Value(item.description),
          imagePath: drift.Value(item.imagePath)));
    }
    return infos;
  } on Exception {
    rethrow;
  }
});

final dataBaseCharactersProvider = Provider(
  (ref) async {
    try {
      final heroDatabase = ref.watch(heroDataBaseProvider);
      var data = await heroDatabase.getHeroInfos();
      if (data.isEmpty) throw Exception();
      final List<HeroInfoModel> infos = [];
      for (var item in data) {
        infos.add(HeroInfoModel.fromDB(item));
      }
      return infos;
    } on Exception {
      rethrow;
    }
  },
);

  Future<HeroInfoModel?> messageHandler(
    RemoteMessage? message, CharactersRepository charactersRepository) async {
  

  if (message != null) {
    final int characterID = int.parse(message.data['character_id']);

    final characterInfo =
        await charactersRepository.getExactCharacter(characterID);
    return characterInfo;
  }
  return null;
}

final characterInfoProvider = FutureProvider((ref) async {
  final charactersRepository = ref.watch(charactersRepositoryProvider);
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  FirebaseMessaging.onMessage.listen(
    (event) {
      print('on message : $event');
      messageHandler(event, charactersRepository);
    },
  );
  FirebaseMessaging.onMessageOpenedApp.listen(((event) {
    print('on message  opened app: $event');
    messageHandler(event, charactersRepository);
  }));

  // FirebaseMessaging.onBackgroundMessage((message) async {
  //   messageHandler(message, charactersRepository);
  // });

  if (initialMessage != null) {
    final int characterID = int.parse(initialMessage.data['character_id']);

    final characterInfo =
        await charactersRepository.getExactCharacter(characterID);
    return characterInfo;
  }
  return null;
});

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infos = ref.watch(charactersInfosProvider);

    final initialHeroInfo = ref.watch(characterInfoProvider);

    initialHeroInfo.whenData((value) {
      if (value != null) {
        Navigator.of(context).pushNamed(MainNavigationRouteName.detailed,
            arguments: HeroInfoArgs(heroInfo: value));
      }
    });

    return Scaffold(
      backgroundColor: mainBackgroundColor,
      body: infos.when(
        loading: (() => const LoadingProgressIndicator()),
        error: ((error, stackTrace) => const DataErrorWidget()),
        data: (data) {
          return CustomPaint(
            painter: BackgroundTrianglePainter(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [const LogoWidget(), SwiperWidget(infos: data)],
              ),
            ),
          );
        },
      ),
    );
  }
}
