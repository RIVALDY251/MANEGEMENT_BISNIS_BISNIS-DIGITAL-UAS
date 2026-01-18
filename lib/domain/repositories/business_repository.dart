import '../entities/business_entity.dart';

abstract class BusinessRepository {
  Future<List<BusinessEntity>> getBusinesses();
  Future<BusinessEntity> getBusiness(String id);
  Future<BusinessEntity> createBusiness(BusinessEntity business);
  Future<BusinessEntity> updateBusiness(BusinessEntity business);
  Future<void> deleteBusiness(String id);
  Future<void> switchBusiness(String id);
  Future<BusinessEntity?> getCurrentBusiness();
}
