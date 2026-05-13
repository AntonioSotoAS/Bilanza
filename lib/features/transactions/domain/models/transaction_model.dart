import 'package:uuid/uuid.dart';

enum TransactionType {
  sale,
  expense,
  personalWithdrawal,
}

/// Modelo de dominio para Transaction
/// Este es el modelo de negocio puro, independiente de la BD
class Transaction {
  final String id;
  final String description;
  final double amount;
  final TransactionType type;
  final DateTime date;

  Transaction({
    String? id,
    required this.description,
    required this.amount,
    required this.type,
    DateTime? date,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now();

  // Para copiar con cambios
  Transaction copyWith({
    String? id,
    String? description,
    double? amount,
    TransactionType? type,
    DateTime? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  @override
  String toString() =>
      'Transaction(id: $id, description: $description, amount: $amount, type: $type, date: $date)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description &&
          amount == other.amount &&
          type == other.type &&
          date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      description.hashCode ^
      amount.hashCode ^
      type.hashCode ^
      date.hashCode;
}