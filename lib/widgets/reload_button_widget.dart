import 'package:flutter/material.dart';

import '../constant/colors.dart';

class ReloadButton extends StatelessWidget {
  final Function() onPressed;
  const ReloadButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: whiteColor, shape: const CircleBorder()),
          onPressed: onPressed,
          child: const Icon(
            Icons.refresh_outlined,
            color: marvelColor,
          )),
    );
  }
}
