class BusinessEntity {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? logo;
  final bool isActive;
  final DateTime createdAt;

  BusinessEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.logo,
    this.isActive = true,
    required this.createdAt,
  });
}
