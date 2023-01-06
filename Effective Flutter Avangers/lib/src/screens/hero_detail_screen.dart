import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_avangers/src/app.dart';
import 'package:effective_avangers/src/constant/colors.dart';
import 'package:effective_avangers/src/constant/main_navigation_route_name.dart';
import 'package:effective_avangers/src/constant/text_styles.dart';
import 'package:effective_avangers/src/models/hero_info_model.dart';
import 'package:flutter/material.dart';

class HeroDetailScreen extends StatelessWidget {
  final HeroInfoModel? heroInfo;
  const HeroDetailScreen({Key? key, required this.heroInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextDirection currentDirection = Directionality.of(context);
    final bool isRTL = currentDirection == TextDirection.rtl;

    return Scaffold(
        body: heroInfo != null
            ? Stack(
                children: [
                  Hero(
                    tag: heroInfo!.id,
                    child: CachedNetworkImage(
                      imageUrl: heroInfo!.imagePath,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),
                  ButtonWidget(
                    isRTL: isRTL,
                  ),
                  TextWidget(
                    heroInfo: heroInfo,
                    isRTL: isRTL,
                  )
                ],
              )
            : const SizedBox.shrink());
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    required this.isRTL,
    Key? key,
  }) : super(key: key);

  final bool isRTL;

  @override
  Widget build(BuildContext context) {
    return isRTL
        ? Positioned(
            top: 40,
            right: 15,
            child: BackButton(
              onPressed: () {
                if (navigatorKey.currentState?.canPop() ?? false) {
                  navigatorKey.currentState?.pop();
                } else {
                  navigatorKey.currentState
                      ?.pushReplacementNamed(MainNavigationRouteName.main);
                }
              },
              color: marvelColor,
            ))
        : Positioned(
            top: 40,
            left: 15,
            child: BackButton(
              onPressed: () {
                if (navigatorKey.currentState?.canPop() ?? false) {
                  navigatorKey.currentState?.pop();
                } else {
                  navigatorKey.currentState
                      ?.pushReplacementNamed(MainNavigationRouteName.main);
                }
              },
              color: marvelColor,
            ));
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.heroInfo,
    required this.isRTL,
  }) : super(key: key);

  final HeroInfoModel? heroInfo;
  final bool isRTL;

  @override
  Widget build(BuildContext context) {
    return isRTL
        ? Positioned(
            right: 15,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: Text(
                    heroInfo!.name,
                    style: nameTextStyle,
                    softWrap: true,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  child: Text(
                    heroInfo!.description,
                    style: descriptionTextStyle,
                    softWrap: true,
                    maxLines: 20,
                  ),
                )
              ],
            ))
        : Positioned(
            left: 15,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    heroInfo!.name,
                    style: nameTextStyle,
                    softWrap: true,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                heroInfo!.description != ''
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
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
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          heroInfo!.description,
                          style: descriptionTextStyle,
                          softWrap: true,
                          maxLines: 20,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ));
  }
}
