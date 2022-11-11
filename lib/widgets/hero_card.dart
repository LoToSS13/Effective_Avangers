import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_avangers/constant/text_styles.dart';
import 'package:effective_avangers/models/hero_info.dart';
import 'package:effective_avangers/screens/hero_detail_screen.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  final HeroInfo heroInfo;
  const HeroCard({Key? key, required this.heroInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HeroDetailScreen(heroInfo: heroInfo))),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Stack(fit: StackFit.passthrough, children: [
            Hero(
              tag: heroInfo.name,
              child: CachedNetworkImage(
                imageUrl: heroInfo.imagePath,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 30,
              left: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: [
                  Text(heroInfo.name, style: nameTextStyle),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
