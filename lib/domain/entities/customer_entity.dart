class CustomerEntity {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String segment; // VIP, Regular, New
  final int totalOrders;
  final double totalSpent;
  final DateTime createdAt;

  CustomerEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    required this.segment,
    this.totalOrders = 0,
    this.totalSpent = 0.0,
    required this.createdAt,
  });
}
