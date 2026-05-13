import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';

// Provider de la base de datos
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});