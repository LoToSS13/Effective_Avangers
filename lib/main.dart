import 'package:card_swiper/card_swiper.dart';
import 'package:effective_avangers/constant/colors.dart';
import 'package:effective_avangers/constant/image_paths.dart';
import 'package:effective_avangers/constant/text_styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avangers',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MainScreen(
        title: 'Choose your hero',
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Color backgroundColor;

  @override
  void initState() {
    super.initState();
    backgroundColor = items[0].backgroundColor;
  }

  final List<HeroInfo> items = [
    const HeroInfo(
        name: 'Captain America',
        imagePath: captainAmericaImagePath,
        backgroundColor: captainAmericaBackgroundColor),
    const HeroInfo(
        name: 'Spider-man',
        imagePath: spiderManImagePath,
        backgroundColor: spiderManBackgroundColor),
    const HeroInfo(
        name: 'Thanos',
        imagePath: thanosImagePath,
        backgroundColor: thanosBackgroundColor),
    const HeroInfo(
        name: 'Thor',
        imagePath: thorImagePath,
        backgroundColor: thorBackgroundColor),
    const HeroInfo(
        name: 'Iron man',
        imagePath: ironManImagePath,
        backgroundColor: ironManBackgroundColor),
    const HeroInfo(
        name: 'Doctor Strange',
        imagePath: doctorStrangeImagePath,
        backgroundColor: doctorStrangeBackgroundColor),
    const HeroInfo(
        name: 'Deadpool',
        imagePath: deadpoolImagePath,
        backgroundColor: deadpoolBackgroundColor),
  ];

  onIndexChanged(int index) {
    setState(() {
      backgroundColor = items[index].backgroundColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      body: CustomPaint(
        painter: MyPainter(color: backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Column(
                children: const [
                  Center(
                    child: Image(
                      height: 40,
                      width: 200,
                      image: AssetImage('lib/images/marvel.png'),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Choose your hero',
                    style: textStyle,
                  ),
                ],
              ),
              Expanded(
                child: Swiper(
                  scale: 0.6,
                  viewportFraction: 1,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HeroCard(
                        name: items[index].name,
                        imagePath: items[index].imagePath);
                  },
                  onIndexChanged: (index) => onIndexChanged(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroInfo {
  final String name;
  final String imagePath;
  final Color backgroundColor;
  const HeroInfo(
      {required this.imagePath,
      required this.name,
      required this.backgroundColor});
}

class HeroCard extends StatelessWidget {
  final String name;
  final String imagePath;
  const HeroCard({Key? key, required this.name, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Stack(fit: StackFit.passthrough, children: [
          Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 30,
            left: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: [
                Text(name, style: textStyle),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color color;

  MyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();
    paint.color = color;

    final path = Path();
    path.moveTo(0, height);

    path.lineTo(width, height * 0.55);
    path.lineTo(width, height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
