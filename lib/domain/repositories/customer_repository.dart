import '../entities/customer_entity.dart';

abstract class CustomerRepository {
  Future<List<CustomerEntity>> getCustomers();
  Future<CustomerEntity> getCustomer(String id);
  Future<CustomerEntity> createCustomer(CustomerEntity customer);
  Future<CustomerEntity> updateCustomer(CustomerEntity customer);
  Future<void> deleteCustomer(String id);
  Future<List<CustomerEntity>> getCustomersBySegment(String segment);
}
