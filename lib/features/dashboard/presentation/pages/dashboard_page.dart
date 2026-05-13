import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../transactions/application/providers/transactions_provider.dart';
import '../../../transactions/domain/models/transaction_model.dart';
import '../../../../core/utils/currency_formatter.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);
    final notifier = ref.read(transactionsProvider.notifier);

    final todayTransactions = notifier.getTodayTransactions();
    final totalSales = notifier.getTotalByType(TransactionType.sale);
    final totalExpenses = notifier.getTotalByType(TransactionType.expense);
    final totalWithdrawals = notifier.getTotalByType(TransactionType.personalWithdrawal);
    final profit = notifier.getProfit();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bilanza'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Resumen de tu negocio',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Controla tus ventas, gastos y ganancias desde el celular.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          _SummaryGrid(
            totalSales: totalSales,
            totalExpenses: totalExpenses,
            profit: profit,
            totalWithdrawals: totalWithdrawals,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Últimos movimientos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () => context.push('/transactions'),
                child: const Text(
                  'Ver todos',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2563EB),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (transactions.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'Sin movimientos',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            )
          else
            ...transactions
                .skip((transactions.length - 3).clamp(0, transactions.length))
                .toList()
                .reversed
                .map((t) => _MiniTransactionItem(transaction: t)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/transactions/new'),
        icon: const Icon(Icons.add),
        label: const Text('Registrar'),
      ),
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  final double totalSales;
  final double totalExpenses;
  final double profit;
  final double totalWithdrawals;

  const _SummaryGrid({
    required this.totalSales,
    required this.totalExpenses,
    required this.profit,
    required this.totalWithdrawals,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SummaryCard(
          title: 'Ventas de hoy',
          value: CurrencyFormatter.format(totalSales),
          icon: Icons.trending_up,
          color: Colors.green,
        ),
        const SizedBox(height: 12),
        _SummaryCard(
          title: 'Gastos de hoy',
          value: CurrencyFormatter.format(totalExpenses),
          icon: Icons.trending_down,
          color: Colors.red,
        ),
        const SizedBox(height: 12),
        _SummaryCard(
          title: 'Ganancia estimada',
          value: CurrencyFormatter.format(profit),
          icon: Icons.account_balance_wallet,
          color: profit >= 0 ? Colors.green : Colors.red,
        ),
        const SizedBox(height: 12),
        _SummaryCard(
          title: 'Retiros personales',
          value: CurrencyFormatter.format(totalWithdrawals),
          icon: Icons.person,
          color: Colors.orange,
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniTransactionItem extends StatelessWidget {
  final dynamic transaction;

  const _MiniTransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final type = transaction.type;
    IconData icon = Icons.receipt;
    Color color = Colors.grey;

    if (type.toString() == 'TransactionType.sale') {
      icon = Icons.arrow_upward;
      color = Colors.green;
    } else if (type.toString() == 'TransactionType.expense') {
      icon = Icons.arrow_downward;
      color = Colors.red;
    } else if (type.toString() == 'TransactionType.personalWithdrawal') {
      icon = Icons.person;
      color = Colors.orange;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${transaction.date.day}/${transaction.date.month}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            CurrencyFormatter.format(transaction.amount),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}