import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/format_utils.dart';
import '../../../core/utils/pdf_generator.dart';
import '../../../core/utils/excel_generator.dart';
import '../../../core/widgets/app_button.dart';
import '../../providers/transaction_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/customer_provider.dart';
import '../dialogs/add_transaction_dialog.dart';

class FinancialScreen extends ConsumerStatefulWidget {
  const FinancialScreen({super.key});

  @override
  ConsumerState<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends ConsumerState<FinancialScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
        title: const Text('Keuangan'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Cashflow'),
            Tab(text: 'Laba Rugi'),
            Tab(text: 'Laporan'),
          ],
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: TabBarView(
          controller: _tabController,
          children: [
            _CashflowTab(),
            _ProfitLossTab(),
            _ReportsTab(),
          ],
        ),
      ),
    );
  }
}

class _CashflowTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);
    final totalIncome = transactions
        .where((t) => t['type'] == 'Pendapatan')
        .fold<double>(0, (sum, t) => sum + (t['amount'] as num).toDouble());
    final totalExpense = transactions
        .where((t) => t['type'] == 'Pengeluaran')
        .fold<double>(0, (sum, t) => sum + (t['amount'] as num).toDouble());
    final netProfit = totalIncome - totalExpense;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Pemasukan',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          FormatUtils.formatCurrency(totalIncome),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                              ),
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
                          'Pengeluaran',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          FormatUtils.formatCurrency(totalExpense),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.error,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Saldo Akhir',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    FormatUtils.formatCurrency(netProfit),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: netProfit > 0 ? AppColors.secondary : AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Riwayat Transaksi',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              FloatingActionButton.small(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddTransactionDialog(
                      onAdd: (transactionData) {
                        ref.read(transactionProvider.notifier).addTransaction(transactionData);
                      },
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (transactions.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(Icons.receipt_long, size: 48, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    Text(
                      'Belum ada transaksi',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey[500],
                          ),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final isIncome = transaction['type'] == 'Pendapatan';
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: (isIncome ? AppColors.success : AppColors.error)
                          // ignore: deprecated_member_use
                          .withOpacity(0.1),
                      child: Icon(
                        isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isIncome ? AppColors.success : AppColors.error,
                      ),
                    ),
                    title: Text(transaction['description']),
                    subtitle: Text(transaction['category']),
                    trailing: Text(
                      '${isIncome ? '+' : '-'}${FormatUtils.formatCurrency(transaction['amount'])}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isIncome ? AppColors.success : AppColors.error,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _ProfitLossTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);
    final totalIncome = transactions
        .where((t) => t['type'] == 'Pendapatan')
        .fold<double>(0, (sum, t) => sum + (t['amount'] as num).toDouble());
    final estimatedCogs = totalIncome * 0.4; // Estimated Cost of Goods Sold 40%
    final grossProfit = totalIncome - estimatedCogs;
    final totalExpense = transactions
        .where((t) => t['type'] == 'Pengeluaran')
        .fold<double>(0, (sum, t) => sum + (t['amount'] as num).toDouble());
    final netProfit = grossProfit - totalExpense;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProfitLossRow('Pendapatan', totalIncome, true, context),
                  const Divider(),
                  _buildProfitLossRow('HPP (COGS)', estimatedCogs, false, context),
                  const Divider(),
                  _buildProfitLossRow('Laba Kotor', grossProfit, true, context),
                  const Divider(),
                  _buildProfitLossRow('Biaya Operasional', totalExpense, false, context),
                  const Divider(),
                  _buildProfitLossRow('Laba Bersih', netProfit, netProfit > 0 ? true : false, context, isTotal: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (totalIncome > 0)
            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: (totalIncome / (totalIncome + estimatedCogs + totalExpense)) * 100,
                      title: 'Pendapatan\n${((totalIncome / (totalIncome + estimatedCogs + totalExpense)) * 100).toStringAsFixed(1)}%',
                      color: AppColors.success,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: (estimatedCogs / (totalIncome + estimatedCogs + totalExpense)) * 100,
                      title: 'HPP\n${((estimatedCogs / (totalIncome + estimatedCogs + totalExpense)) * 100).toStringAsFixed(1)}%',
                      color: AppColors.warning,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: (totalExpense / (totalIncome + estimatedCogs + totalExpense)) * 100,
                      title: 'Operasional\n${((totalExpense / (totalIncome + estimatedCogs + totalExpense)) * 100).toStringAsFixed(1)}%',
                      color: AppColors.error,
                      radius: 50,
                    ),
                  ],
                ),
              ),
            )
          else
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'Tidak ada data transaksi untuk menampilkan grafik',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfitLossRow(String label, double amount, bool isPositive,
      BuildContext context, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                ),
          ),
          Text(
            FormatUtils.formatCurrency(amount),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isPositive ? AppColors.success : AppColors.error,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}

class _ReportsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);
    final totalIncome = transactions
        .where((t) => t['type'] == 'Pendapatan')
        .fold<double>(0, (sum, t) => sum + (t['amount'] as num).toDouble());
    final totalExpense = transactions
        .where((t) => t['type'] == 'Pengeluaran')
        .fold<double>(0, (sum, t) => sum + (t['amount'] as num).toDouble());
    final netProfit = totalIncome - totalExpense;
    
    // Import product and customer providers data untuk komprehensif PDF
    final products = ref.watch(productProvider);
    final customers = ref.watch(customerProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Export Laporan',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    label: 'Download Laporan PDF',
                    icon: Icons.download,
                    onPressed: () async {
                      try {
                        await PDFGenerator.generateComprehensiveFinancialReportPDF(
                          title: 'Laporan Keuangan',
                          data: {
                            'Pendapatan': totalIncome,
                            'Pengeluaran': totalExpense,
                            'Laba Bersih': netProfit,
                          },
                          transactions: transactions,
                          products: products,
                          customers: customers,
                          startDate: DateTime.now().subtract(const Duration(days: 30)),
                          endDate: DateTime.now(),
                        );
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('❌ Error: ${e.toString()}')),
                          );
                        }
                      }
                    },
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: 'Export Excel',
                    icon: Icons.table_chart,
                    type: AppButtonType.outline,
                    onPressed: () async {
                      await ExcelGenerator.generateFinancialReportExcel(
                        fileName: 'Laporan_Keuangan_${DateTime.now().millisecondsSinceEpoch}',
                        data: {
                          'Pendapatan': totalIncome,
                          'Pengeluaran': totalExpense,
                          'Laba Bersih': netProfit,
                        },
                        startDate: DateTime.now().subtract(const Duration(days: 30)),
                        endDate: DateTime.now(),
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Excel Laporan berhasil dibuat')),
                        );
                      }
                    },
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Ringkasan Laporan Terbaru
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ringkasan Laporan Terbaru',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildReportRow('Total Pendapatan', totalIncome, true, context),
                  const SizedBox(height: 12),
                  _buildReportRow('Total Pengeluaran', totalExpense, false, context),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  _buildReportRow('Laba Bersih', netProfit, netProfit > 0 ? true : false, context, isTotal: true),
                  const SizedBox(height: 16),
                  // Business Recommendations
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: AppColors.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.info),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb, color: AppColors.info, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Rekomendasi Bisnis',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.info,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ..._generateBusinessRecommendations(totalIncome, totalExpense, netProfit, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportRow(String label, double amount, bool isPositive, BuildContext context, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
        ),
        Text(
          FormatUtils.formatCurrency(amount),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isPositive ? AppColors.success : AppColors.error,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ],
    );
  }

  List<Widget> _generateBusinessRecommendations(double income, double expense, double profit, BuildContext context) {
    final recommendations = <Widget>[];
    
    // Recommendation 1: Profitability Check
    if (profit <= 0) {
      recommendations.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              const Icon(Icons.warning, color: Colors.orange, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pengeluaran melebihi pendapatan. Pertimbangkan untuk mengurangi biaya operasional.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final profitMargin = (profit / income) * 100;
      if (profitMargin < 20) {
        recommendations.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.blue, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Margin keuntungan Anda adalah ${profitMargin.toStringAsFixed(1)}%. Tingkatkan harga atau kurangi biaya untuk meningkatkan profitabilitas.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    // Recommendation 2: Cash Flow
    if (expense > income * 0.7) {
      recommendations.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              const Icon(Icons.warning, color: Colors.orange, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pengeluaran mencapai ${((expense / income) * 100).toStringAsFixed(1)}% dari pendapatan. Optimalkan pengeluaran untuk meningkatkan cash flow.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Recommendation 3: Growth opportunity
    if (income > 0) {
      recommendations.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              const Icon(Icons.trending_up, color: Colors.green, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Investasi dalam pemasaran dapat meningkatkan pendapatan. Alokasikan 5-10% dari profit untuk pertumbuhan bisnis.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Default recommendation if no other applies
    if (recommendations.isEmpty) {
      recommendations.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Kinerja keuangan Anda baik. Pertahankan strategi saat ini dan terus monitor pertumbuhan.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return recommendations;
  }
}
