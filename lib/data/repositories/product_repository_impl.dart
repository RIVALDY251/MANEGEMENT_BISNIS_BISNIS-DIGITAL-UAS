import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      await localDataSource.saveProducts(products);
      return products;
    } catch (e) {
      // Fallback to local data
      return await localDataSource.getProducts();
    }
  }

  @override
  Future<ProductEntity> getProduct(String id) async {
    final localProduct = await localDataSource.getProduct(id);
    if (localProduct != null) return localProduct;
    
    return await remoteDataSource.getProduct(id);
  }

  @override
  Future<ProductEntity> createProduct(ProductEntity product) async {
    final created = await remoteDataSource.createProduct(product);
    final products = await localDataSource.getProducts();
    products.add(created);
    await localDataSource.saveProducts(products);
    return created;
  }

  @override
  Future<ProductEntity> updateProduct(ProductEntity product) async {
    final updated = await remoteDataSource.updateProduct(product);
    final products = await localDataSource.getProducts();
    final index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index] = updated;
      await localDataSource.saveProducts(products);
    }
    return updated;
  }

  @override
  Future<void> deleteProduct(String id) async {
    await remoteDataSource.deleteProduct(id);
    final products = await localDataSource.getProducts();
    products.removeWhere((p) => p.id == id);
    await localDataSource.saveProducts(products);
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    final products = await getProducts();
    return products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
