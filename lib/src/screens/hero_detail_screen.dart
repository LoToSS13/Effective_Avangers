import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_avangers/src/constant/colors.dart';
import 'package:effective_avangers/src/constant/text_styles.dart';
import 'package:effective_avangers/src/models/hero_info_model.dart';
import 'package:flutter/material.dart';

class HeroDetailScreen extends StatelessWidget {
  final HeroInfoModel? heroInfo;
  const HeroDetailScreen({Key? key, required this.heroInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Positioned(
                      top: 40,
                      left: 15,
                      child: BackButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: marvelColor,
                      )),
                  Positioned(
                      left: 15,
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
                ],
              )
            : const SizedBox.shrink());
  }
}
