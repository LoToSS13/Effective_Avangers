import 'package:effective_avangers/constant/colors.dart';
import 'package:effective_avangers/constant/image_paths.dart';
import 'package:effective_avangers/constant/text_styles.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          const Center(
            child: Image(
              height: 40,
              width: 200,
              image: AssetImage(logoPath),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Choose your hero',
            style: nameTextStyle(whiteColor),
          ),
        ],
      ),
    );
  }
}
