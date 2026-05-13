import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'transaction_model.g.dart';

enum TransactionType {
  sale,
  expense,
  personalWithdrawal,
}

@collection
class Transaction {
  Id id = Isar.autoIncrement;
  late String uuid;
  late String description;
  late double amount;
  late TransactionType type;
  late DateTime date;

  Transaction({
    required this.description,
    required this.amount,
    required this.type,
    DateTime? date,
  }) {
    this.date = date ?? DateTime.now();
    uuid = const Uuid().v4();
  }
}