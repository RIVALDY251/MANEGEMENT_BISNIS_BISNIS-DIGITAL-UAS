import '../entities/invoice_entity.dart';

abstract class InvoiceRepository {
  Future<List<InvoiceEntity>> getInvoices();
  Future<InvoiceEntity> getInvoice(String id);
  Future<InvoiceEntity> createInvoice(InvoiceEntity invoice);
  Future<InvoiceEntity> updateInvoice(InvoiceEntity invoice);
  Future<void> deleteInvoice(String id);
  Future<String> generateInvoicePdf(String invoiceId);
}
