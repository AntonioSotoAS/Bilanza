import 'package:drift/drift.dart';

/// Tabla de transacciones en Drift
class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get description => text()();
  RealColumn get amount => real()();
  IntColumn get type => integer()(); // 0: sale, 1: expense, 2: personalWithdrawal
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}