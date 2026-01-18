import '../entities/transaction_entity.dart';

abstract class FinancialRepository {
  Future<List<TransactionEntity>> getTransactions({
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  });
  Future<TransactionEntity> createTransaction(TransactionEntity transaction);
  Future<Map<String, dynamic>> getCashflow({
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Map<String, dynamic>> getProfitLoss({
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> exportToPdf(Map<String, dynamic> data);
  Future<void> exportToExcel(Map<String, dynamic> data);
}
