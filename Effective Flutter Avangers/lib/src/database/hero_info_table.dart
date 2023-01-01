import 'package:drift/drift.dart';

class HeroInfo extends Table {
  IntColumn get id => integer().named('id')();
  TextColumn get name => text().named('name')();
  TextColumn get description => text().named('description')();
  TextColumn get imagePath => text().named('imagePath')();
}
