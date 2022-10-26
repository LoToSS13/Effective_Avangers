import 'package:card_swiper/card_swiper.dart';
import 'package:effective_avangers/models/infos.dart';
import 'package:effective_avangers/widgets/hero_card.dart';
import 'package:flutter/material.dart';

class SwiperWidget extends StatelessWidget {
  final Function(int) onIndexChanged;
  const SwiperWidget({Key? key, required this.onIndexChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Swiper(
        scale: 0.6,
        viewportFraction: 1,
        itemCount: infos.length,
        itemBuilder: (BuildContext context, int index) {
          return HeroCard(
            heroInfo: infos[index],
          );
        },
        onIndexChanged: (index) => onIndexChanged(index),
      ),
    );
  }
}

onIndexChanged(int index) {}
