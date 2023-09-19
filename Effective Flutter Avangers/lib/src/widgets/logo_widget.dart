import 'package:effective_avangers/src/constant/image_paths.dart';
import 'package:effective_avangers/src/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations.of(context)!.mainScreenMessage,
            style: nameTextStyle,
          ),
        ],
      ),
    );
  }
}
