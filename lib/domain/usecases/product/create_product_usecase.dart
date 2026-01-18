import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';

class CreateProductUseCase {
  final ProductRepository repository;

  CreateProductUseCase(this.repository);

  Future<ProductEntity> execute(ProductEntity product) {
    return repository.createProduct(product);
  }
}
