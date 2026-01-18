import '../../entities/invoice_entity.dart';
import '../../repositories/invoice_repository.dart';

class CreateInvoiceUseCase {
  final InvoiceRepository repository;

  CreateInvoiceUseCase(this.repository);

  Future<InvoiceEntity> execute(InvoiceEntity invoice) {
    return repository.createInvoice(invoice);
  }
}
