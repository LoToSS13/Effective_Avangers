import 'package:card_swiper/card_swiper.dart';
import 'package:effective_avangers/src/models/hero_info_model.dart';
import 'package:effective_avangers/src/widgets/hero_card.dart';
import 'package:flutter/material.dart';

class SwiperWidget extends StatelessWidget {
  final List<HeroInfoModel>? infos;
  const SwiperWidget({Key? key, required this.infos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return infos != null
        ? Expanded(
            child: Swiper(
              scale: 0.6,
              viewportFraction: 1,
              itemCount: infos!.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  child: HeroCard(
                    heroInfo: infos![index],
                  ),
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
