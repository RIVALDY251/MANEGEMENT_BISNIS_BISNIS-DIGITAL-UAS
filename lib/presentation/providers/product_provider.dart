import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = StateNotifierProvider<ProductNotifier, List<Map<String, dynamic>>>((ref) {
  return ProductNotifier();
});

class ProductNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ProductNotifier() : super([
    {
      'id': '1',
      'name': 'Laptop Pro',
      'price': 15000000,
      'stock': 5,
      'category': 'Electronics',
      'description': 'High-performance laptop untuk profesional',
      'image': 'assets/images/laptop.png',
    },
    {
      'id': '2',
      'name': 'Mouse Wireless',
      'price': 500000,
      'stock': 20,
      'category': 'Accessories',
      'description': 'Mouse ergonomis dengan 3 DPI setting',
      'image': 'assets/images/mouse.png',
    },
    {
      'id': '3',
      'name': 'Keyboard Mekanik',
      'price': 2500000,
      'stock': 12,
      'category': 'Accessories',
      'description': 'RGB keyboard dengan switch mekanik cherry',
      'image': 'assets/images/keyboard.png',
    },
  ]);

  void addProduct(Map<String, dynamic> product) {
    final newProduct = {
      ...product,
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
    };
    state = [...state, newProduct];
  }

  void updateProduct(String id, Map<String, dynamic> product) {
    state = [
      for (final prod in state)
        if (prod['id'] == id) {...prod, ...product} else prod,
    ];
  }

  void deleteProduct(String id) {
    state = state.where((prod) => prod['id'] != id).toList();
  }

  int getTotalStock() {
    return state.fold<int>(0, (sum, prod) => sum + (prod['stock'] as int));
  }

  double getTotalInventoryValue() {
    return state.fold<double>(
      0,
      (sum, prod) => sum + ((prod['price'] as num) * (prod['stock'] as num)).toDouble(),
    );
  }

  List<Map<String, dynamic>> getByCategory(String category) {
    return state.where((prod) => prod['category'] == category).toList();
  }
}
