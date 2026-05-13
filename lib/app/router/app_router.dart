  import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/transactions/presentation/pages/new_transaction_page.dart';
import '../../features/transactions/presentation/pages/transactions_page.dart';
import '../../features/debts/presentation/pages/debts_page.dart';
import '../../features/personal_finance/presentation/pages/personal_finance_page.dart';
import '../../features/reports/presentation/pages/reports_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/transactions',
      name: 'transactions',
      builder: (context, state) => const TransactionsPage(),
    ),
    GoRoute(
      path: '/transactions/new',
      name: 'new-transaction',
      builder: (context, state) => const NewTransactionPage(),
    ),
    GoRoute(
      path: '/debts',
      name: 'debts',
      builder: (context, state) => const DebtsPage(),
    ),
    GoRoute(
      path: '/personal-finance',
      name: 'personal-finance',
      builder: (context, state) => const PersonalFinancePage(),
    ),
    GoRoute(
      path: '/reports',
      name: 'reports',
      builder: (context, state) => const ReportsPage(),
    ),
  ],
);