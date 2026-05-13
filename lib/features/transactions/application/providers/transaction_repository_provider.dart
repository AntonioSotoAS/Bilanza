import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_provider.dart';
import '../../../core/database/app_database.dart';
import '../../data/datasources/transaction_local_datasource.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/transaction_repository_interface.dart';

// Provider de la fuente de datos local
final transactionLocalDataSourceProvider = Provider<TransactionLocalDataSource>((ref) {
  final database = ref.watch(databaseProvider);
  return TransactionLocalDataSource(database);
});

// Provider del repositorio
final transactionRepositoryProvider = Provider<ITransactionRepository>((ref) {
  final dataSource = ref.watch(transactionLocalDataSourceProvider);
  return TransactionRepository(dataSource);
});