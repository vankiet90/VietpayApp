// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CurrencyTableTable extends CurrencyTable
    with TableInfo<$CurrencyTableTable, CurrencyTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrencyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [code, rate, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currency_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CurrencyTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  CurrencyTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrencyTableData(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CurrencyTableTable createAlias(String alias) {
    return $CurrencyTableTable(attachedDatabase, alias);
  }
}

class CurrencyTableData extends DataClass
    implements Insertable<CurrencyTableData> {
  final String code;
  final double rate;
  final DateTime updatedAt;
  const CurrencyTableData({
    required this.code,
    required this.rate,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['rate'] = Variable<double>(rate);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CurrencyTableCompanion toCompanion(bool nullToAbsent) {
    return CurrencyTableCompanion(
      code: Value(code),
      rate: Value(rate),
      updatedAt: Value(updatedAt),
    );
  }

  factory CurrencyTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrencyTableData(
      code: serializer.fromJson<String>(json['code']),
      rate: serializer.fromJson<double>(json['rate']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'rate': serializer.toJson<double>(rate),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CurrencyTableData copyWith({
    String? code,
    double? rate,
    DateTime? updatedAt,
  }) => CurrencyTableData(
    code: code ?? this.code,
    rate: rate ?? this.rate,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CurrencyTableData copyWithCompanion(CurrencyTableCompanion data) {
    return CurrencyTableData(
      code: data.code.present ? data.code.value : this.code,
      rate: data.rate.present ? data.rate.value : this.rate,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyTableData(')
          ..write('code: $code, ')
          ..write('rate: $rate, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, rate, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrencyTableData &&
          other.code == this.code &&
          other.rate == this.rate &&
          other.updatedAt == this.updatedAt);
}

class CurrencyTableCompanion extends UpdateCompanion<CurrencyTableData> {
  final Value<String> code;
  final Value<double> rate;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CurrencyTableCompanion({
    this.code = const Value.absent(),
    this.rate = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrencyTableCompanion.insert({
    required String code,
    required double rate,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       rate = Value(rate),
       updatedAt = Value(updatedAt);
  static Insertable<CurrencyTableData> custom({
    Expression<String>? code,
    Expression<double>? rate,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (rate != null) 'rate': rate,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrencyTableCompanion copyWith({
    Value<String>? code,
    Value<double>? rate,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CurrencyTableCompanion(
      code: code ?? this.code,
      rate: rate ?? this.rate,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyTableCompanion(')
          ..write('code: $code, ')
          ..write('rate: $rate, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CurrencyTableTable currencyTable = $CurrencyTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [currencyTable];
}

typedef $$CurrencyTableTableCreateCompanionBuilder =
    CurrencyTableCompanion Function({
      required String code,
      required double rate,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CurrencyTableTableUpdateCompanionBuilder =
    CurrencyTableCompanion Function({
      Value<String> code,
      Value<double> rate,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CurrencyTableTableFilterComposer
    extends Composer<_$AppDatabase, $CurrencyTableTable> {
  $$CurrencyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CurrencyTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CurrencyTableTable> {
  $$CurrencyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CurrencyTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurrencyTableTable> {
  $$CurrencyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CurrencyTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CurrencyTableTable,
          CurrencyTableData,
          $$CurrencyTableTableFilterComposer,
          $$CurrencyTableTableOrderingComposer,
          $$CurrencyTableTableAnnotationComposer,
          $$CurrencyTableTableCreateCompanionBuilder,
          $$CurrencyTableTableUpdateCompanionBuilder,
          (
            CurrencyTableData,
            BaseReferences<
              _$AppDatabase,
              $CurrencyTableTable,
              CurrencyTableData
            >,
          ),
          CurrencyTableData,
          PrefetchHooks Function()
        > {
  $$CurrencyTableTableTableManager(_$AppDatabase db, $CurrencyTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurrencyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurrencyTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CurrencyTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrencyTableCompanion(
                code: code,
                rate: rate,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required double rate,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CurrencyTableCompanion.insert(
                code: code,
                rate: rate,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CurrencyTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CurrencyTableTable,
      CurrencyTableData,
      $$CurrencyTableTableFilterComposer,
      $$CurrencyTableTableOrderingComposer,
      $$CurrencyTableTableAnnotationComposer,
      $$CurrencyTableTableCreateCompanionBuilder,
      $$CurrencyTableTableUpdateCompanionBuilder,
      (
        CurrencyTableData,
        BaseReferences<_$AppDatabase, $CurrencyTableTable, CurrencyTableData>,
      ),
      CurrencyTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CurrencyTableTableTableManager get currencyTable =>
      $$CurrencyTableTableTableManager(_db, _db.currencyTable);
}
