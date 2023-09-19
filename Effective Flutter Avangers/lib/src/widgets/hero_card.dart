import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_avangers/src/constant/text_styles.dart';
import 'package:effective_avangers/src/models/hero_info_args.dart';
import 'package:effective_avangers/src/models/hero_info_model.dart';
import 'package:flutter/material.dart';

import '../constant/main_navigation_route_name.dart';

class HeroCard extends StatelessWidget {
  final HeroInfoModel heroInfo;
  const HeroCard({Key? key, required this.heroInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextDirection currentDirection = Directionality.of(context);
    final bool isRTL = currentDirection == TextDirection.rtl;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
            MainNavigationRouteName.detailed,
            arguments: HeroInfoArgs(heroInfo: heroInfo)),
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
            TextWidget(
                heroInfo: heroInfo,
                currentDirection: currentDirection,
                isRTL: isRTL),
          ]),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.heroInfo,
    required this.currentDirection,
    required this.isRTL,
  }) : super(key: key);

  final HeroInfoModel heroInfo;
  final TextDirection currentDirection;
  final bool isRTL;

  @override
  Widget build(BuildContext context) {
    return isRTL
        ? Positioned(
            bottom: 30,
            right: 40,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.45),
                    ),
                    const BoxShadow(
                      color: Colors.white70,
                      spreadRadius: -5.0,
                      blurRadius: 20.0,
                    ),
                  ],
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(25)),
              width: 300,
              child: Text(
                heroInfo.name,
                style: nameTextStyle,
                textAlign: TextAlign.center,
                maxLines: 3,
                softWrap: true,
                textDirection: currentDirection,
              ),
            ),
          )
        : Positioned(
            bottom: 30,
            left: 40,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.45),
                    ),
                    const BoxShadow(
                      color: Colors.white70,
                      spreadRadius: -5.0,
                      blurRadius: 20.0,
                    ),
                  ],
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(25)),
              width: 300,
              child: Text(
                heroInfo.name,
                style: nameTextStyle,
                textAlign: TextAlign.center,
                maxLines: 3,
                softWrap: true,
                textDirection: currentDirection,
              ),
            ),
          );
  }
}
