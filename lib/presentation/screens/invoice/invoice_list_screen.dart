import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/format_utils.dart';
import '../../../core/utils/pdf_generator.dart';
import '../../../core/widgets/empty_state.dart';
import 'invoice_create_screen.dart';
import 'invoice_detail_screen.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  final List<Map<String, dynamic>> _invoices = [
    {
      'id': 'INV001',
      'customer': 'Pelanggan A',
      'amount': 500000,
      'status': 'paid',
      'date': '2024-01-15',
    },
    {
      'id': 'INV002',
      'customer': 'Pelanggan B',
      'amount': 750000,
      'status': 'pending',
      'date': '2024-01-16',
    },
    {
      'id': 'INV003',
      'customer': 'Pelanggan C',
      'amount': 1000000,
      'status': 'overdue',
      'date': '2024-01-10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Pastikan back button muncul
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: _invoices.isEmpty
          ? EmptyState(
              icon: Icons.receipt_long,
              title: 'Belum Ada Invoice',
              message: 'Buat invoice pertama Anda',
              actionLabel: 'Buat Invoice',
              onAction: () {},
            )
          : Column(
              children: [
                // Summary
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.backgroundLight,
                  child: Row(
                    children: [
                      Expanded(
                        child: _SummaryItem(
                          label: 'Total Invoice',
                          value: _invoices.length.toString(),
                          icon: Icons.receipt,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.borderLight,
                      ),
                      Expanded(
                        child: _SummaryItem(
                          label: 'Belum Dibayar',
                          value: _invoices
                              .where((i) => i['status'] != 'paid')
                              .length
                              .toString(),
                          icon: Icons.pending,
                        ),
                      ),
                    ],
                  ),
                ),
                // Invoice List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _invoices.length,
                    itemBuilder: (context, index) {
                      final invoice = _invoices[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _getStatusColor(invoice['status'] as String)
                                  // ignore: deprecated_member_use
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              _getStatusIcon(invoice['status'] as String),
                              color: _getStatusColor(invoice['status'] as String),
                            ),
                          ),
                          title: Text(
                            invoice['id'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(invoice['customer'] as String),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(
                                        invoice['status'] as String,
                                      // ignore: deprecated_member_use
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      _getStatusLabel(invoice['status'] as String),
                                      style: TextStyle(
                                        color: _getStatusColor(
                                          invoice['status'] as String,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    invoice['date'] as String,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                FormatUtils.formatCurrency(
                                  invoice['amount'] as double,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.visibility, size: 20),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InvoiceDetailScreen(
                                            invoice: invoice,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.download, size: 20),
                                    onPressed: () async {
                                      await PDFGenerator.generateInvoicePDF(
                                        invoiceId: invoice['id'] as String,
                                        customerName: invoice['customer'] as String,
                                        items: [
                                          {
                                            'name': 'Item 1',
                                            'quantity': 1,
                                            'price': invoice['amount'] as double,
                                            'total': invoice['amount'] as double,
                                          },
                                        ],
                                        total: invoice['amount'] as double,
                                        date: DateTime.parse(invoice['date'] as String),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InvoiceCreateScreen(),
            ),
          );
          if (result == true) {
            // Refresh list
            setState(() {});
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Buat Invoice'),
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

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'paid':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      case 'overdue':
        return Icons.error;
      default:
        return Icons.receipt;
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

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
