import 'package:drift/drift.dart';

class CurrencyTable extends Table {
  TextColumn get code => text()();

  RealColumn get rate => real()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {code};
}
