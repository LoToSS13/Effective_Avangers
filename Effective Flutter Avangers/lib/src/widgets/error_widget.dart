import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DataErrorWidget extends StatelessWidget {
  const DataErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextDirection currentDirection = Directionality.of(context);
    return Center(
      child: Text(
        AppLocalizations.of(context)!.somethinkWentWrong,
        textDirection: currentDirection,
      ),
    );
  }
}
