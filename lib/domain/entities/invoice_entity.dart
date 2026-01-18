class InvoiceItemEntity {
  final String name;
  final int quantity;
  final double price;
  final double total;

  InvoiceItemEntity({
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
  });
}

class InvoiceEntity {
  final String id;
  final String customerId;
  final String customerName;
  final List<InvoiceItemEntity> items;
  final double total;
  final String status; // paid, pending, overdue
  final DateTime createdAt;
  final DateTime? paidAt;

  InvoiceEntity({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
    this.paidAt,
  });
}
