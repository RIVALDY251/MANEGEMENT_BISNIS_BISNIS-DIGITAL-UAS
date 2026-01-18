import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductEntity>> getProducts();
  Future<void> saveProducts(List<ProductEntity> products);
  Future<ProductEntity?> getProduct(String id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _key = 'products';

  ProductLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<ProductEntity>> getProducts() async {
    final jsonString = sharedPreferences.getString(_key);
    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveProducts(List<ProductEntity> products) async {
    final jsonList = products
        .map((product) => (product as ProductModel).toJson())
        .toList();
    await sharedPreferences.setString(_key, json.encode(jsonList));
  }

  @override
  Future<ProductEntity?> getProduct(String id) async {
    final products = await getProducts();
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
