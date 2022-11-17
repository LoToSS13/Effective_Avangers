import 'dart:async';

import 'package:effective_avangers/constant/colors.dart';
import 'package:effective_avangers/constant/keys.dart';
import 'package:effective_avangers/database/hero_database.dart';
import 'package:effective_avangers/models/hero_info_data.dart';
import 'package:effective_avangers/network/api_client.dart';
import 'package:effective_avangers/widgets/logo_widget.dart';
import 'package:effective_avangers/widgets/background_triangle_painter.dart';
import 'package:effective_avangers/widgets/swiper_widget.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:drift/drift.dart' as drift;

import '../widgets/reload_button_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late HeroDatabase heroDatabase;
  PaletteGenerator? paletteGenerator;
  Color backgroundColor = marvelColor;
  List<HeroInfoModel> infos = [];
  late String errorMessage = '';
  bool generated = false;
  late Widget child;
  bool shouldSaveToDb = false;

  Future<void> atStart() async {
    heroDatabase = HeroDatabase();
    await getData();
    await generateBackgroundColors();
  }

  Future<void> getData() async {
    try {
      if (infos.isEmpty && errorMessage.isEmpty) {
        await getDataFromDatabase();
      }
    } on Exception {
      try {
        infos = await ApiClient().getChars(publicKey, privateKey, '29');
        shouldSaveToDb = true;
      } on Exception {
        errorMessage = 'Got some troubles here, Doc';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: marvelColor,
        ));
      }
    }
    setState(() {});
  }

  Future<void> getDataFromDatabase() async {
    try {
      var data = await heroDatabase.getHeroInfos();
      if (data.isEmpty) throw Exception();
      HeroInfoModel model;
      for (var item in data) {
        model = HeroInfoModel(
            id: item.id,
            imagePath: item.imagePath,
            name: item.name,
            description: item.description);
        model.backgroundColor = Color(item.backgroundColor);
        model.textColor = Color(item.textColor);
        infos.add(model);
      }
    } on Exception {
      rethrow;
    }

    setState(() {});
  }

  Future<void> generateBackgroundColors() async {
    if (!generated) {
      generated = true;
      for (var item in infos) {
        if (item.backgroundColor == null || item.textColor == null) {
          paletteGenerator = await PaletteGenerator.fromImageProvider(
            NetworkImage(item.imagePath),
            maximumColorCount: 20,
          );
          item.textColor =
              paletteGenerator!.dominantColor?.bodyTextColor.withOpacity(1);
          item.backgroundColor = paletteGenerator!.dominantColor!.color;
        }
      }
      saveInfos();
    }
  }

  Future<void> saveInfos() async {
    if (shouldSaveToDb) {
      shouldSaveToDb = false;
      HeroInfoCompanion entity;
      for (HeroInfoModel item in infos) {
        entity = HeroInfoCompanion(
            name: drift.Value(item.name),
            description: drift.Value(item.description),
            textColor: drift.Value(item.textColor!.value),
            backgroundColor: drift.Value(item.backgroundColor!.value),
            imagePath: drift.Value(item.imagePath));
        heroDatabase.insertHeroInfo(entity);
      }
    }
  }

  onIndexChanged(int index) {
    setState(() {
      if (infos.isNotEmpty && infos[index].backgroundColor != null) {
        backgroundColor = infos[index].backgroundColor!;
      }
    });
  }

  onReloadButtonPressed() {
    errorMessage = '';
    getData();
  }

  @override
  Widget build(BuildContext context) {
    atStart();
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      body: CustomPaint(
        painter: BackgroundTrianglePainter(color: backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              const LogoWidget(),
              infos.isEmpty
                  ? ReloadButton(onPressed: onReloadButtonPressed)
                  : SwiperWidget(
                      onIndexChanged: onIndexChanged,
                      infos: infos,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
