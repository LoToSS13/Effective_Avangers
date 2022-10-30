import 'package:drift/drift.dart';

class HeroInfo extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named('name')();
  TextColumn get description => text().named('description')();
  IntColumn get textColor => integer().named('textColor')();
  IntColumn get backgroundColor => integer().named('backgroundColor')();
  TextColumn get imagePath => text().named('imagePath')();
}
