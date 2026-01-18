import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/format_utils.dart';
import '../../../core/utils/pdf_generator.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_back_button.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final Map<String, dynamic> invoice;

  const InvoiceDetailScreen({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    final items = List.generate(3, (index) {
      return {
        'name': 'Item ${index + 1}',
        'quantity': index + 1,
        'price': 100000.0,
        'total': 100000.0 * (index + 1),
      };
    });

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text('Invoice ${invoice['id'] as String}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              await PDFGenerator.generateInvoicePDF(
                invoiceId: invoice['id'] as String,
                customerName: invoice['customer'] as String,
                items: items,
                total: invoice['amount'] as double,
                date: DateTime.parse(invoice['date'] as String),
              );
              // ignore: use_build_context_synchronously
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invoice disiapkan untuk dibagikan')));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Invoice Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              invoice['id'] as String,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              FormatUtils.formatDate(
                                DateTime.parse(invoice['date'] as String),
                              ),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(invoice['status'] as String)
                                // ignore: deprecated_member_use
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getStatusLabel(invoice['status'] as String),
                            style: TextStyle(
                              color: _getStatusColor(invoice['status'] as String),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      'Kepada:',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      invoice['customer'] as String,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Items
            Text(
              'Item Invoice',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 16),
                        SizedBox(width: 60, child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                        SizedBox(width: 16),
                        SizedBox(width: 100, child: Text('Harga', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
                        SizedBox(width: 16),
                        SizedBox(width: 100, child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
                      ],
                    ),
                  ),
                  // Items
                  ...items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(child: Text(item['name'] as String)),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 60,
                            child: Text(
                              '${item['quantity']}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 100,
                            child: Text(
                              FormatUtils.formatCurrency(item['price'] as double),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 100,
                            child: Text(
                              FormatUtils.formatCurrency(item['total'] as double),
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const Divider(),
                  // Total
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          FormatUtils.formatCurrency(invoice['amount'] as double),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Actions
            AppButton(
              label: 'Download PDF',
              icon: Icons.download,
              onPressed: () async {
                await PDFGenerator.generateInvoicePDF(
                  invoiceId: invoice['id'] as String,
                  customerName: invoice['customer'] as String,
                  items: items,
                  total: invoice['amount'] as double,
                  date: DateTime.parse(invoice['date'] as String),
                );
              },
              width: double.infinity,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Edit',
                    type: AppButtonType.outline,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fitur edit belum tersedia')));
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    label: 'Hapus',
                    type: AppButtonType.outline,
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Hapus Invoice'),
                          content: const Text('Yakin ingin menghapus invoice ini?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
                            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus')),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context); // close detail
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invoice dihapus')));
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'overdue':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'paid':
        return 'Lunas';
      case 'pending':
        return 'Menunggu';
      case 'overdue':
        return 'Terlambat';
      default:
        return status;
    }
  }
}
