import 'package:effective_avangers/constant/colors.dart';
import 'package:effective_avangers/constant/keys.dart';
import 'package:effective_avangers/models/hero_info.dart';
import 'package:effective_avangers/network/api_client.dart';
import 'package:effective_avangers/widgets/logo_widget.dart';
import 'package:effective_avangers/widgets/my_painter.dart';
import 'package:effective_avangers/widgets/swiper_widget.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PaletteGenerator? paletteGenerator;
  Color backgroundColor = marvelColor;
  List<HeroInfo> infos = [];
  String errorMessage = '';
  bool generated = false;
  late Widget child;

  Future<void> getData() async {
    try {
      if (infos.isEmpty && errorMessage.isEmpty) {
        infos = await ApiClient().getChars(apiKey, hash, '29');
      }
    } on Exception {
      errorMessage = 'Got some troubles here, Doc';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: marvelColor,
      ));
    }
    setState(() {});
  }

  Future<void> generateBackGroundColors() async {
    await getData();
    if (!generated) {
      generated = true;
      for (var item in infos) {
        paletteGenerator = await PaletteGenerator.fromImageProvider(
          NetworkImage(item.imagePath),
          maximumColorCount: 20,
        );
        item.backgroundColor = paletteGenerator!.dominantColor!.color;
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

  @override
  Widget build(BuildContext context) {
    if (infos.isEmpty) {
      child = Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: whiteColor, shape: const CircleBorder()),
            onPressed: () {
              errorMessage = '';
              getData();
            },
            child: const Icon(
              Icons.refresh_outlined,
              color: marvelColor,
            )),
      );
    } else {
      child = SwiperWidget(
        onIndexChanged: onIndexChanged,
        infos: infos,
      );
    }

    generateBackGroundColors();
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      body: CustomPaint(
        painter: MyPainter(color: backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [const LogoWidget(), child],
          ),
        ),
      ),
    );
  }
}
