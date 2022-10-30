// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class HeroInfoData extends DataClass implements Insertable<HeroInfoData> {
  final int id;
  final String name;
  final String description;
  final int textColor;
  final int backgroundColor;
  final String imagePath;
  const HeroInfoData(
      {required this.id,
      required this.name,
      required this.description,
      required this.textColor,
      required this.backgroundColor,
      required this.imagePath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['textColor'] = Variable<int>(textColor);
    map['backgroundColor'] = Variable<int>(backgroundColor);
    map['imagePath'] = Variable<String>(imagePath);
    return map;
  }

  HeroInfoCompanion toCompanion(bool nullToAbsent) {
    return HeroInfoCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      textColor: Value(textColor),
      backgroundColor: Value(backgroundColor),
      imagePath: Value(imagePath),
    );
  }

  factory HeroInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HeroInfoData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      textColor: serializer.fromJson<int>(json['textColor']),
      backgroundColor: serializer.fromJson<int>(json['backgroundColor']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'textColor': serializer.toJson<int>(textColor),
      'backgroundColor': serializer.toJson<int>(backgroundColor),
      'imagePath': serializer.toJson<String>(imagePath),
    };
  }

  HeroInfoData copyWith(
          {int? id,
          String? name,
          String? description,
          int? textColor,
          int? backgroundColor,
          String? imagePath}) =>
      HeroInfoData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        textColor: textColor ?? this.textColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        imagePath: imagePath ?? this.imagePath,
      );
  @override
  String toString() {
    return (StringBuffer('HeroInfoData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('textColor: $textColor, ')
          ..write('backgroundColor: $backgroundColor, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, textColor, backgroundColor, imagePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HeroInfoData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.textColor == this.textColor &&
          other.backgroundColor == this.backgroundColor &&
          other.imagePath == this.imagePath);
}

class HeroInfoCompanion extends UpdateCompanion<HeroInfoData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> textColor;
  final Value<int> backgroundColor;
  final Value<String> imagePath;
  const HeroInfoCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.textColor = const Value.absent(),
    this.backgroundColor = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  HeroInfoCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required int textColor,
    required int backgroundColor,
    required String imagePath,
  })  : name = Value(name),
        description = Value(description),
        textColor = Value(textColor),
        backgroundColor = Value(backgroundColor),
        imagePath = Value(imagePath);
  static Insertable<HeroInfoData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? textColor,
    Expression<int>? backgroundColor,
    Expression<String>? imagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (textColor != null) 'textColor': textColor,
      if (backgroundColor != null) 'backgroundColor': backgroundColor,
      if (imagePath != null) 'imagePath': imagePath,
    });
  }

  HeroInfoCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<int>? textColor,
      Value<int>? backgroundColor,
      Value<String>? imagePath}) {
    return HeroInfoCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (textColor.present) {
      map['textColor'] = Variable<int>(textColor.value);
    }
    if (backgroundColor.present) {
      map['backgroundColor'] = Variable<int>(backgroundColor.value);
    }
    if (imagePath.present) {
      map['imagePath'] = Variable<String>(imagePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HeroInfoCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('textColor: $textColor, ')
          ..write('backgroundColor: $backgroundColor, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }
}

class $HeroInfoTable extends HeroInfo
    with TableInfo<$HeroInfoTable, HeroInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HeroInfoTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _textColorMeta = const VerificationMeta('textColor');
  @override
  late final GeneratedColumn<int> textColor = GeneratedColumn<int>(
      'textColor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _backgroundColorMeta =
      const VerificationMeta('backgroundColor');
  @override
  late final GeneratedColumn<int> backgroundColor = GeneratedColumn<int>(
      'backgroundColor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'imagePath', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, textColor, backgroundColor, imagePath];
  @override
  String get aliasedName => _alias ?? 'hero_info';
  @override
  String get actualTableName => 'hero_info';
  @override
  VerificationContext validateIntegrity(Insertable<HeroInfoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('textColor')) {
      context.handle(_textColorMeta,
          textColor.isAcceptableOrUnknown(data['textColor']!, _textColorMeta));
    } else if (isInserting) {
      context.missing(_textColorMeta);
    }
    if (data.containsKey('backgroundColor')) {
      context.handle(
          _backgroundColorMeta,
          backgroundColor.isAcceptableOrUnknown(
              data['backgroundColor']!, _backgroundColorMeta));
    } else if (isInserting) {
      context.missing(_backgroundColorMeta);
    }
    if (data.containsKey('imagePath')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['imagePath']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HeroInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HeroInfoData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      textColor: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}textColor'])!,
      backgroundColor: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}backgroundColor'])!,
      imagePath: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}imagePath'])!,
    );
  }

  @override
  $HeroInfoTable createAlias(String alias) {
    return $HeroInfoTable(attachedDatabase, alias);
  }
}

abstract class _$HeroDatabase extends GeneratedDatabase {
  _$HeroDatabase(QueryExecutor e) : super(e);
  late final $HeroInfoTable heroInfo = $HeroInfoTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [heroInfo];
}
