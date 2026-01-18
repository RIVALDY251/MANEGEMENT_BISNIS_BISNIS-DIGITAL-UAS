class ProductEntity {
  final String id;
  final String name;
  final double price;
  final int stock;
  final String category;
  final String? description;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    this.description,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });
}
