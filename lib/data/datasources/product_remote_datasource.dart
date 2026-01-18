import 'package:dio/dio.dart';
import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductEntity>> getProducts();
  Future<ProductEntity> getProduct(String id);
  Future<ProductEntity> createProduct(ProductEntity product);
  Future<ProductEntity> updateProduct(ProductEntity product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      // Mock API call
      await Future.delayed(const Duration(seconds: 1));
      
      // In real implementation:
      // final response = await dio.get('${AppConstants.baseUrl}/products');
      // return (response.data as List)
      //     .map((json) => ProductModel.fromJson(json))
      //     .toList();

      // Mock data
      return [
        ProductModel(
          id: '1',
          name: 'Produk A',
          price: 50000,
          stock: 100,
          category: 'Kategori 1',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }

  @override
  Future<ProductEntity> getProduct(String id) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    return ProductModel(
      id: id,
      name: 'Produk',
      price: 50000,
      stock: 100,
      category: 'Kategori',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<ProductEntity> createProduct(ProductEntity product) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    return product;
  }

  @override
  Future<ProductEntity> updateProduct(ProductEntity product) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    return product;
  }

  @override
  Future<void> deleteProduct(String id) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
  }
}
