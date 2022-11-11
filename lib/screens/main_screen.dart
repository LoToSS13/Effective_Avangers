import 'package:effective_avangers/constant/colors.dart';
import 'package:effective_avangers/models/infos.dart';
import 'package:effective_avangers/widgets/logo_widget.dart';
import 'package:effective_avangers/widgets/my_painter.dart';
import 'package:effective_avangers/widgets/swiper_widget.dart';
import 'package:flutter/material.dart';

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
    backgroundColor = infos[0].backgroundColor;
  }

  onIndexChanged(int index) {
    setState(() {
      backgroundColor = infos[index].backgroundColor;
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
              const LogoWidget(),
              SwiperWidget(
                onIndexChanged: onIndexChanged,
              )
            ],
          ),
        ),
      ),
    );
  }
}
