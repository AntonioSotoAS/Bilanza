import '../datasources/transaction_local_datasource.dart';
import '../../domain/models/transaction_model.dart';
import '../../domain/repositories/transaction_repository_interface.dart';

class TransactionRepository implements ITransactionRepository {
  final TransactionLocalDataSource _localDataSource;

  TransactionRepository(this._localDataSource);

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await _localDataSource.insertTransaction(transaction);
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    await _localDataSource.updateTransaction(transaction);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await _localDataSource.deleteTransaction(id);
  }

  @override
  Future<Transaction?> getTransactionById(String id) async {
    return await _localDataSource.getTransactionById(id);
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    return await _localDataSource.getAllTransactions();
  }

  @override
  Future<List<Transaction>> getTodayTransactions() async {
    return await _localDataSource.getTodayTransactions();
  }

  @override
  Future<List<Transaction>> getTransactionsByType(TransactionType type) async {
    return await _localDataSource.getTransactionsByType(type);
  }

  @override
  Future<double> getTotalByType(TransactionType type) async {
    final transactions = await _localDataSource.getTransactionsByType(type);
    return transactions.fold(0.0, (sum, t) => sum + t.amount);
  }

  @override
  Future<double> getProfit() async {
    final sales = await getTotalByType(TransactionType.sale);
    final expenses = await getTotalByType(TransactionType.expense);
    final withdrawals = await getTotalByType(TransactionType.personalWithdrawal);
    return sales - expenses - withdrawals;
  }
}