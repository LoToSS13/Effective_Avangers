import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'hero_info_table.dart';

part 'hero_database.g.dart';

LazyDatabase _openConnectiont() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'heroInfo .sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [HeroInfo])
class HeroDatabase extends _$HeroDatabase {
  HeroDatabase() : super(_openConnectiont());

  @override
  int get schemaVersion => 1;

  Future<List<HeroInfoData>> getHeroInfos() async {
    return await select(heroInfo).get();
  }

  Future<HeroInfoData> getHeroInfo(int id) async {
    return await (select(heroInfo)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .getSingle();
  }

  Future<bool> updateHeroInfo(HeroInfoCompanion entity) async {
    return await update(heroInfo).replace(entity);
  }

  Future<int> insertHeroInfo(HeroInfoCompanion entity) async {
    return await into(heroInfo).insert(entity);
  }

  Future<int> deleteHeroInfo(int id) async {
    return await (delete(heroInfo)..where((tbl) => tbl.id.equals(id))).go();
  }
}
