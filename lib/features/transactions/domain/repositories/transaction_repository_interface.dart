import '../../domain/models/transaction_model.dart';

abstract class ITransactionRepository {
  Future<void> addTransaction(Transaction transaction);
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(String id);
  Future<Transaction?> getTransactionById(String id);
  Future<List<Transaction>> getAllTransactions();
  Future<List<Transaction>> getTodayTransactions();
  Future<List<Transaction>> getTransactionsByType(TransactionType type);
  Future<double> getTotalByType(TransactionType type);
  Future<double> getProfit();
}