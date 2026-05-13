import 'package:drift/drift.dart' hide Column;

import '../../../core/database/app_database.dart';
import '../../../core/database/app_database_schema.dart';
import '../../domain/models/transaction_model.dart';

/// Local data source para acceder a transacciones en Drift
class TransactionLocalDataSource {
  final AppDatabase _database;

  TransactionLocalDataSource(this._database);

  Future<void> insertTransaction(Transaction transaction) async {
    final companion = TransactionsCompanion(
      id: Value(transaction.id),
      description: Value(transaction.description),
      amount: Value(transaction.amount),
      type: Value(_typeToInt(transaction.type)),
      date: Value(transaction.date),
    );
    await _database.insertTransaction(companion);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    final dbTransaction = Transactions(
      id: transaction.id,
      description: transaction.description,
      amount: transaction.amount,
      type: _typeToInt(transaction.type),
      date: transaction.date,
      createdAt: DateTime.now(),
    );
    await _database.updateTransaction(dbTransaction);
  }

  Future<void> deleteTransaction(String id) async {
    await _database.deleteTransaction(id);
  }

  Future<Transaction?> getTransactionById(String id) async {
    final result = await _database.getTransactionById(id);
    return result != null ? _mapToTransaction(result) : null;
  }

  Future<List<Transaction>> getAllTransactions() async {
    final results = await _database.getAllTransactions();
    return results.map(_mapToTransaction).toList();
  }

  Future<List<Transaction>> getTodayTransactions() async {
    final results = await _database.getTodayTransactions();
    return results.map(_mapToTransaction).toList();
  }

  Future<List<Transaction>> getTransactionsByType(TransactionType type) async {
    final typeInt = _typeToInt(type);
    final results = await _database.getTransactionsByType(typeInt);
    return results.map(_mapToTransaction).toList();
  }

  // Mapeos
  int _typeToInt(TransactionType type) {
    switch (type) {
      case TransactionType.sale:
        return 0;
      case TransactionType.expense:
        return 1;
      case TransactionType.personalWithdrawal:
        return 2;
    }
  }

  TransactionType _intToType(int type) {
    switch (type) {
      case 0:
        return TransactionType.sale;
      case 1:
        return TransactionType.expense;
      case 2:
        return TransactionType.personalWithdrawal;
      default:
        return TransactionType.sale;
    }
  }

  Transaction _mapToTransaction(Transactions dbTransaction) {
    return Transaction(
      id: dbTransaction.id,
      description: dbTransaction.description,
      amount: dbTransaction.amount,
      type: _intToType(dbTransaction.type),
      date: dbTransaction.date,
    );
  }
}