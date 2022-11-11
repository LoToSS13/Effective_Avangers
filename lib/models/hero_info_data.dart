import 'package:flutter/material.dart';

class HeroInfoModel {
  final String name;
  final String imagePath;
  Color? backgroundColor;
  Color? textColor;
  final String description;
  HeroInfoModel(
      {required this.imagePath, required this.name, required this.description});

  factory HeroInfoModel.fromJSON(Map<String, dynamic> json) {
    return HeroInfoModel(
        imagePath:
            json['thumbnail']['path'] + '.' + json['thumbnail']['extension'],
        name: json['name'],
        description: json['description']);
  }
}
