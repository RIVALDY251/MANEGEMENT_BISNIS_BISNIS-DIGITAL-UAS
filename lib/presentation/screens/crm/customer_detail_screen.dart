import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/format_utils.dart';

class CustomerDetailScreen extends StatelessWidget {
  final Map<String, dynamic> customer;

  const CustomerDetailScreen({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Pastikan back button muncul
        title: const Text(AppConstants.appName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      // ignore: deprecated_member_use
                      backgroundColor: AppColors.secondary.withOpacity(0.1),
                      child: Text(
                        (customer['name'] as String)[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer['name'] as String,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            customer['email'] as String,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getSegmentColor(customer['segment'] as String)
                                  // ignore: deprecated_member_use
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              customer['segment'] as String,
                              style: TextStyle(
                                color: _getSegmentColor(customer['segment'] as String),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Contact Info
            Text(
              'Informasi Kontak',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(customer['email'] as String),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Telepon'),
                    subtitle: Text(customer['phone'] as String? ?? '-'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Statistics
            Text(
              'Statistik',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '${customer['totalOrders']}',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Total Pesanan',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            FormatUtils.formatCurrency(customer['totalSpent'] as double),
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Total Belanja',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Purchase History
            Text(
              'Riwayat Pembelian',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...List.generate(5, (index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.receipt),
                  title: Text('Invoice #INV${1000 + index}'),
                  subtitle: Text('${index + 1} Jan 2024'),
                  trailing: Text(
                    FormatUtils.formatCurrency(500000 * (index + 1)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  onTap: () {
                    // Mock invoice data
                    final invoice = {
                      'id': 'INV-${DateTime.now().millisecondsSinceEpoch}',
                      'date': DateTime.now().toIso8601String(),
                      'customer': customer['name'] as String,
                      'status': 'paid',
                      'total': 500000.0,
                    };
                    context.push('/invoice-detail', extra: invoice);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Color _getSegmentColor(String segment) {
    switch (segment) {
      case 'VIP':
        return AppColors.warning;
      case 'Regular':
        return AppColors.info;
      case 'New':
        return AppColors.secondary;
      default:
        return AppColors.textSecondary;
    }
  }
}
