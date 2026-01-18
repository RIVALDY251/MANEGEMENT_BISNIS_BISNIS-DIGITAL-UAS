import '../../entities/customer_entity.dart';
import '../../repositories/customer_repository.dart';

class GetCustomersUseCase {
  final CustomerRepository repository;

  GetCustomersUseCase(this.repository);

  Future<List<CustomerEntity>> execute() {
    return repository.getCustomers();
  }
}
