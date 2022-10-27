import 'package:flutter/material.dart';

class HeroInfo {
  final String name;
  final String imagePath;
  Color? backgroundColor;
  final String description;
  HeroInfo(
      {required this.imagePath, required this.name, required this.description});
}
