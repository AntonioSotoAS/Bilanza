import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'dart:io';

import 'app_database_schema.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Operaciones de transacciones
  Future<void> insertTransaction(TransactionsCompanion transaction) async {
    await into(transactions).insert(transaction);
  }

  Future<void> updateTransaction(Transactions transaction) async {
    await update(transactions).replace(transaction);
  }

  Future<void> deleteTransaction(String id) async {
    await (delete(transactions)..where((t) => t.id.equals(id))).go();
  }

  Future<Transactions?> getTransactionById(String id) async {
    return (select(transactions)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<Transactions>> getAllTransactions() async {
    return select(transactions).get();
  }

  Future<List<Transactions>> getTodayTransactions() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay =
        DateTime(today.year, today.month, today.day, 23, 59, 59, 999);

    return (select(transactions)
          ..where((t) =>
              t.date.isBetweenValues(startOfDay, endOfDay)))
        .get();
  }

  Future<List<Transactions>> getTransactionsByType(int type) async {
    return (select(transactions)..where((t) => t.type.equals(type))).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await driftDataFolder();
    final file = File('$dbFolder/bilanza.db');

    if (file.parent.existsSync() == false) {
      await file.parent.create(recursive: true);
    }

    return NativeDatabase.createInBackground(file);
  });
}
