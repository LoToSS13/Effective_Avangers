import 'package:effective_avangers/src/database/hero_database.dart';
import 'package:effective_avangers/src/models/hero_info_data.dart';
import 'package:effective_avangers/src/widgets/background_triangle_painter.dart';
import 'package:effective_avangers/src/widgets/error_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:drift/drift.dart' as drift;

import '../../main.dart';
import '../constant/colors.dart';
import '../widgets/logo_widget.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/swiper_widget.dart';

final charactersInfosProvider = FutureProvider((ref) async {
  try {
    final infos = await ref.watch(networkCharactersProvider);
    return infos;
  } on Exception {
    final infos = await ref.watch(dataBaseCharactersProvider);
    return infos;
  }
});

final networkCharactersProvider = Provider((ref) async {
  try {
    final charactersRepository = ref.watch(charactersRepositoryProvider);
    final infos = await charactersRepository.getCharacters('58');
    final heroDatabase = ref.watch(heroDataBaseProvider);

    for (HeroInfoModel item in infos) {
      heroDatabase.insertHeroInfo(HeroInfoCompanion(
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

      return fetchCharacters(data);
    } on Exception {
      rethrow;
    }
  },
);

List<HeroInfoModel> fetchCharacters(List<HeroInfoData> data) {
  if (data.isEmpty) throw Exception();
  final List<HeroInfoModel> infos = [];
  for (var item in data) {
    infos.add(HeroInfoModel.fromDB(item));
  }
  return infos;
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infos = ref.watch(charactersInfosProvider);

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
                children: [
                  const LogoWidget(),
                  // PageView.builder(
                  //   itemCount: data.length,

                  //   itemBuilder: (context, index) {
                  //     return HeroCard(heroInfo: data[index]);
                  //   },
                  // ignore: unnecessary_null_comparison
                  if (data != null) SwiperWidget(infos: data) // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
