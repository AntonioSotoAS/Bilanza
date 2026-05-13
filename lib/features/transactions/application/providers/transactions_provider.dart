import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/transaction_model.dart';

// Notifier para manejar el estado de transacciones
class TransactionsNotifier extends Notifier<List<Transaction>> {
  @override
  List<Transaction> build() {
    return [];
  }

  // Agregar nueva transacción
  void addTransaction(Transaction transaction) {
    state = [...state, transaction];
  }

  // Eliminar transacción
  void removeTransaction(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  // Actualizar transacción
  void updateTransaction(Transaction transaction) {
    state = state.map((t) => t.id == transaction.id ? transaction : t).toList();
  }

  // Obtener transacciones del día
  List<Transaction> getTodayTransactions() {
    final today = DateTime.now();
    return state.where((t) {
      return t.date.year == today.year &&
          t.date.month == today.month &&
          t.date.day == today.day;
    }).toList();
  }

  // Calcular total por tipo
  double getTotalByType(TransactionType type) {
    return state
        .where((t) => t.type == type)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // Calcular ganancias (ventas - gastos - retiros)
  double getProfit() {
    double sales = getTotalByType(TransactionType.sale);
    double expenses = getTotalByType(TransactionType.expense);
    double withdrawals = getTotalByType(TransactionType.personalWithdrawal);
    return sales - expenses - withdrawals;
  }
}

// Provider de transacciones
final transactionsProvider = NotifierProvider<TransactionsNotifier, List<Transaction>>(() {
  return TransactionsNotifier();
});