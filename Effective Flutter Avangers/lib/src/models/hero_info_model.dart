import '../database/hero_database.dart';

class HeroInfoModel {
  final int id;
  final String name;
  final String imagePath;
  final String description;
  const HeroInfoModel(
      {required this.imagePath,
      required this.name,
      required this.description,
      required this.id});

  factory HeroInfoModel.fromJSON(Map<String, dynamic> json) {
    return HeroInfoModel(
        imagePath:
            json['thumbnail']['path'] + '.' + json['thumbnail']['extension'],
        name: json['name'],
        description: json['description'],
        id: json['id']);
  }

  factory HeroInfoModel.fromDB(HeroInfoData data) {
    return HeroInfoModel(
        id: data.id,
        imagePath: data.imagePath,
        name: data.name,
        description: data.description);
  }

  @override
  String toString() {
    return 'id : $id name : $name description : $description imagePath: $imagePath';
  }
}
