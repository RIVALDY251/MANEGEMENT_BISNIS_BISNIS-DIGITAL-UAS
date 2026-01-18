import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/format_utils.dart';

class ProductTransactionHistoryScreen extends StatelessWidget {
  final String productId;
  final String productName;

  const ProductTransactionHistoryScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    final transactions = List.generate(10, (index) {
      return {
        'id': 'TXN${1000 + index}',
        'type': index % 3 == 0 ? 'in' : 'out',
        'quantity': (index + 1) * 5,
        'price': 50000.0,
        'total': 50000.0 * (index + 1) * 5,
        'date': DateTime.now().subtract(Duration(days: index)),
        'reference': 'Invoice #INV${1000 + index}',
      };
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Pastikan back button muncul
        title: const Text(AppConstants.appName),
      ),
      body: Column(
        children: [
          // Product Info
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.backgroundLight,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.inventory_2,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Riwayat Transaksi',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Transactions List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final isIn = transaction['type'] == 'in';
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (isIn ? AppColors.success : AppColors.error)
                            // ignore: deprecated_member_use
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isIn ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isIn ? AppColors.success : AppColors.error,
                      ),
                    ),
                    title: Text(
                      transaction['id'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '${transaction['quantity']} unit - ${FormatUtils.formatCurrency(transaction['price'] as double)}/unit',
                        ),
                        const SizedBox(height: 4),
                        Text(
                          FormatUtils.formatDate(transaction['date'] as DateTime),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (transaction['reference'] != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            transaction['reference'] as String,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${isIn ? '+' : '-'}${FormatUtils.formatCurrency(transaction['total'] as double)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isIn ? AppColors.success : AppColors.error,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: (isIn ? AppColors.success : AppColors.error)
                                // ignore: deprecated_member_use
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isIn ? 'Masuk' : 'Keluar',
                            style: TextStyle(
                              fontSize: 10,
                              color: isIn ? AppColors.success : AppColors.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
