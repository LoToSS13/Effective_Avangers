import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_avangers/src/constant/text_styles.dart';
import 'package:effective_avangers/src/models/hero_info_data.dart';
import 'package:effective_avangers/src/screens/hero_detail_screen.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  final HeroInfoModel heroInfo;
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
              tag: heroInfo.id,
              child: CachedNetworkImage(
                imageUrl: heroInfo.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 30,
              left: 40,
              child: SizedBox(
                width: 300,
                child: Text(
                  heroInfo.name,
                  style: nameTextStyle,
                  maxLines: 3,
                  softWrap: true,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
