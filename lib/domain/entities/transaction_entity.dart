class TransactionEntity {
  final String id;
  final String type; // income, expense
  final String category;
  final double amount;
  final String description;
  final DateTime date;
  final String? referenceId; // invoice id, etc

  TransactionEntity({
    required this.id,
    required this.type,
    required this.category,
    required this.amount,
    required this.description,
    required this.date,
    this.referenceId,
  });
}
