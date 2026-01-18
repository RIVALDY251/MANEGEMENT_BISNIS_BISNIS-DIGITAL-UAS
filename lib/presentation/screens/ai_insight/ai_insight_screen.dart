import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/app_back_button.dart';

class AIInsightScreen extends StatefulWidget {
  const AIInsightScreen({super.key});

  @override
  State<AIInsightScreen> createState() => _AIInsightScreenState();
}

class _AIInsightScreenState extends State<AIInsightScreen> {
  final List<Map<String, dynamic>> _insights = [
    {
      'type': 'recommendation',
      'title': 'Rekomendasi Stok',
      'message':
          'Produk A memiliki stok rendah. Pertimbangkan untuk menambah stok untuk menghindari kehabisan.',
      'icon': Icons.inventory_2,
      'color': AppColors.warning,
    },
    {
      'type': 'prediction',
      'title': 'Prediksi Penjualan',
      'message':
          'Berdasarkan data historis, penjualan diprediksi akan meningkat 20% pada bulan depan.',
      'icon': Icons.trending_up,
      'color': AppColors.success,
    },
    {
      'type': 'alert',
      'title': 'Peringatan Cashflow',
      'message':
          'Pengeluaran bulan ini melebihi 80% dari pendapatan. Perhatikan pengelolaan keuangan.',
      'icon': Icons.warning,
      'color': AppColors.error,
    },
    {
      'type': 'opportunity',
      'title': 'Peluang Bisnis',
      'message':
          'Pelanggan VIP menunjukkan minat tinggi pada kategori baru. Pertimbangkan untuk memperluas produk.',
      'icon': Icons.lightbulb,
      'color': AppColors.info,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Insight AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Merefresh insight...')));
            },
          ),
        ],
      ),
      body: _insights.isEmpty
          ? EmptyState(
              icon: Icons.psychology,
              title: 'Belum Ada Insight',
              message: 'Insight akan muncul setelah Anda memiliki cukup data',
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Card(
                    // ignore: deprecated_member_use
                    color: AppColors.secondary.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.psychology,
                            color: AppColors.secondary,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AI Business Insight',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  'Analisis otomatis untuk membantu keputusan bisnis Anda',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Insights List
                  ..._insights.map((insight) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: (insight['color'] as Color)
                                        // ignore: deprecated_member_use
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    insight['icon'] as IconData,
                                    color: insight['color'] as Color,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    insight['title'] as String,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Chip(
                                  label: Text(
                                    _getTypeLabel(insight['type'] as String),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  backgroundColor: (insight['color'] as Color)
                                      // ignore: deprecated_member_use
                                      .withOpacity(0.1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              insight['message'] as String,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(insight['title'] as String),
                                        content: Text(insight['message'] as String),
                                        actions: [
                                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text('Lihat Detail'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tindakan dijalankan (placeholder)')));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: insight['color'] as Color,
                                  ),
                                  child: const Text('Tindakan'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'recommendation':
        return 'Rekomendasi';
      case 'prediction':
        return 'Prediksi';
      case 'alert':
        return 'Peringatan';
      case 'opportunity':
        return 'Peluang';
      default:
        return type;
    }
  }
}
