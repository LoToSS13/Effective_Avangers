import 'package:effective_avangers/src/constant/colors.dart';
import 'package:flutter/material.dart';

class LoadingProgressIndicator extends StatelessWidget {
  const LoadingProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: whiteColor,
      ),
    );
  }
}
