import 'package:flutter/material.dart';

class HeroInfo {
  final String name;
  final String imagePath;
  final Color backgroundColor;
  final String description;
  const HeroInfo(
      {required this.imagePath,
      required this.name,
      required this.backgroundColor,
      required this.description});
}
