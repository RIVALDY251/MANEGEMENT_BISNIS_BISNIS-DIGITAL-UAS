import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/format_utils.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;
  String _selectedPeriod = 'Bulan Ini'; // Period selector

  // Mock data - dalam aplikasi nyata ini akan dari provider/API
  final Map<String, dynamic> _dashboardData = {
    'totalRevenue': 12500000,
    'revenueChange': 12.5, // percentage
    'totalExpense': 8500000,
    'expenseChange': -5.2,
    'netProfit': 4000000,
    'profitChange': 18.3,
    'totalProducts': 45,
    'productsChange': 3,
    'totalCustomers': 128,
    'customersChange': 8,
    'totalInvoices': 156,
    'invoicesChange': 15,
  };

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.dashboard,
      label: 'Dashboard',
      route: '/dashboard',
    ),
    NavigationItem(
      icon: Icons.account_balance_wallet,
      label: 'Keuangan',
      route: '/financial',
    ),
    NavigationItem(icon: Icons.inventory, label: 'Produk', route: '/products'),
    NavigationItem(icon: Icons.people, label: 'CRM', route: '/crm'),
    NavigationItem(
      icon: Icons.settings,
      label: 'Pengaturan',
      route: '/settings',
    ),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    
    setState(() {
      _selectedIndex = index;
    });
    
    final route = _navigationItems[index].route;
    try {
      context.go(route);
    } catch (e) {
      debugPrint('Navigation error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Dashboard utama tidak perlu back button
        title: Row(
          children: [
            Hero(
              tag: 'app_logo',
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.business,
                  size: 20,
                  color: AppColors.textLight,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.appName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Dashboard',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.business),
            onPressed: () => context.push('/business-profile'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _navigationItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.label,
              ),
            )
            .toList(),
        type: BottomNavigationBarType.fixed,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate refresh
          await Future.delayed(const Duration(seconds: 1));
          if (!mounted) return;
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data diperbarui'),
              backgroundColor: AppColors.success,
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              const _WelcomeSection(),
              const SizedBox(height: 24),
              // Period Selector dengan styling yang lebih menarik
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    // ignore: deprecated_member_use
                    color: AppColors.primary.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.analytics_outlined,
                          color: AppColors.secondary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ringkasan Keuangan',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Data real-time dari bisnis Anda',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderLight),
                        // ignore: deprecated_member_use
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: AppColors.primary.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          DropdownButton<String>(
                            value: _selectedPeriod,
                            underline: const SizedBox(),
                            isDense: true,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            items:
                                [
                                      'Hari Ini',
                                      'Minggu Ini',
                                      'Bulan Ini',
                                      'Tahun Ini',
                                    ]
                                    .map(
                                      (period) => DropdownMenuItem(
                                        value: period,
                                        child: Text(period),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedPeriod = value);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Menampilkan data: $value'),
                                    backgroundColor: AppColors.success,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Summary Cards Grid - Layout yang lebih padat dan profesional
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: [
                  // Card 1: Total Pendapatan (Featured)
                  _SummaryCard(
                    title: 'Total Pendapatan',
                    amount: _dashboardData['totalRevenue'] as double,
                    icon: Icons.trending_up,
                    color: AppColors.success,
                    change: _dashboardData['revenueChange'] as double,
                    isFeatured: true,
                    subtitle: 'Bulan ini',
                  ),
                  // Card 2: Total Pengeluaran (Featured)
                  _SummaryCard(
                    title: 'Total Pengeluaran',
                    amount: _dashboardData['totalExpense'] as double,
                    icon: Icons.trending_down,
                    color: AppColors.error,
                    change: _dashboardData['expenseChange'] as double,
                    isFeatured: true,
                    subtitle: 'Bulan ini',
                  ),
                  // Card 3: Laba Bersih (Featured)
                  _SummaryCard(
                    title: 'Laba Bersih',
                    amount: _dashboardData['netProfit'] as double,
                    icon: Icons.account_balance_wallet,
                    color: AppColors.secondary,
                    change: _dashboardData['profitChange'] as double,
                    isFeatured: true,
                    subtitle: 'Keuntungan bulan ini',
                  ),
                  // Card 4: Total Produk
                  _SummaryCard(
                    title: 'Total Produk',
                    amount: _dashboardData['totalProducts'] as double,
                    icon: Icons.inventory_2,
                    color: AppColors.info,
                    isCount: true,
                    change: _dashboardData['productsChange'] as double,
                    subtitle: 'Item aktif',
                  ),
                  // Card 5: Total Pelanggan
                  _SummaryCard(
                    title: 'Total Pelanggan',
                    amount: _dashboardData['totalCustomers'] as double,
                    icon: Icons.people,
                    color: AppColors.warning,
                    isCount: true,
                    change: _dashboardData['customersChange'] as double,
                    subtitle: 'Pelanggan aktif',
                  ),
                  // Card 6: Total Invoice
                  _SummaryCard(
                    title: 'Total Invoice',
                    amount: _dashboardData['totalInvoices'] as double,
                    icon: Icons.receipt_long,
                    color: AppColors.primary,
                    isCount: true,
                    change: _dashboardData['invoicesChange'] as double,
                    subtitle: 'Bulan ini',
                  ),
                  // Card 4: Total Produk
                  _SummaryCard(
                    title: 'Total Produk',
                    amount: _dashboardData['totalProducts'] as double,
                    icon: Icons.inventory_2,
                    color: AppColors.info,
                    isCount: true,
                    change: _dashboardData['productsChange'] as double,
                    subtitle: 'Item aktif',
                  ),
                  // Card 5: Total Pelanggan
                  _SummaryCard(
                    title: 'Total Pelanggan',
                    amount: _dashboardData['totalCustomers'] as double,
                    icon: Icons.people,
                    color: AppColors.warning,
                    isCount: true,
                    change: _dashboardData['customersChange'] as double,
                    subtitle: 'Pelanggan aktif',
                  ),
                  // Card 6: Total Invoice
                  _SummaryCard(
                    title: 'Total Invoice',
                    amount: _dashboardData['totalInvoices'] as double,
                    icon: Icons.receipt_long,
                    color: AppColors.primary,
                    isCount: true,
                    change: _dashboardData['invoicesChange'] as double,
                    subtitle: 'Bulan ini',
                  ),
                ],
              ),
              // Statistik Tambahan - Full Width
              const SizedBox(height: 16),
              _SummaryCard(
                title: 'Rata-rata Nilai Order',
                amount:
                    (_dashboardData['totalRevenue'] as double) /
                    (_dashboardData['totalInvoices'] as double),
                icon: Icons.shopping_cart,
                color: AppColors.secondary,
                subtitle: 'Per invoice bulan ini',
                isFullWidth: true,
              ),
              const SizedBox(height: 24),
              // Quick Actions
              Text('Aksi Cepat', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _QuickActionCard(
                    icon: Icons.receipt,
                    label: 'Invoice Baru',
                    color: AppColors.primary,
                    onTap: () => context.push('/invoices'),
                  ),
                  _QuickActionCard(
                    icon: Icons.add_box,
                    label: 'Tambah Produk',
                    color: AppColors.secondary,
                    onTap: () => context.push('/products'),
                  ),
                  _QuickActionCard(
                    icon: Icons.person_add,
                    label: 'Tambah Pelanggan',
                    color: AppColors.info,
                    onTap: () => context.push('/crm'),
                  ),
                  _QuickActionCard(
                    icon: Icons.insights,
                    label: 'Analytics',
                    color: AppColors.warning,
                    onTap: () => context.push('/analytics'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Revenue Chart
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grafik Pendapatan',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton.icon(
                            onPressed: () => context.push('/analytics'),
                            icon: const Icon(Icons.arrow_forward, size: 16),
                            label: const Text('Lihat Detail'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 220,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  // ignore: deprecated_member_use
                                  color: AppColors.borderLight.withOpacity(0.3),
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Text(
                                        '${(value / 1000).toStringAsFixed(0)}K',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const days = [
                                      'Sen',
                                      'Sel',
                                      'Rab',
                                      'Kam',
                                      'Jum',
                                      'Sab',
                                      'Min',
                                    ];
                                    if (value.toInt() >= 0 &&
                                        value.toInt() < days.length) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          days[value.toInt()],
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      );
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              // ignore: deprecated_member_use
                              border: Border.all(
                                // ignore: deprecated_member_use
                                color: AppColors.borderLight.withOpacity(0.3),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  const FlSpot(0, 2.5),
                                  const FlSpot(1, 3.8),
                                  const FlSpot(2, 3.2),
                                  const FlSpot(3, 5.1),
                                  const FlSpot(4, 4.5),
                                  const FlSpot(5, 6.2),
                                  const FlSpot(6, 7.5),
                                ],
                                isCurved: true,
                                color: AppColors.secondary,
                                barWidth: 3,
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) {
                                        return FlDotCirclePainter(
                                          radius: 4,
                                          color: AppColors.secondary,
                                          strokeWidth: 2,
                                          strokeColor: AppColors.surfaceLight,
                                        );
                                      },
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  // ignore: deprecated_member_use
                                  color: AppColors.secondary.withOpacity(0.1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Recent Transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaksi Terkini',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () => context.push('/invoices'),
                    child: const Text('Lihat Semua'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  final customers = [
                    'PT. Maju Jaya',
                    'CV. Sejahtera',
                    'Toko Makmur',
                    'UD. Berkah',
                    'PT. Sukses',
                  ];
                  final statuses = [
                    'Lunas',
                    'Pending',
                    'Lunas',
                    'Lunas',
                    'Pending',
                  ];
                  final statusColors = [
                    AppColors.success,
                    AppColors.warning,
                    AppColors.success,
                    AppColors.success,
                    AppColors.warning,
                  ];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        // ignore: deprecated_member_use
                        backgroundColor: AppColors.secondary.withOpacity(0.1),
                        child: const Icon(
                          Icons.receipt,
                          color: AppColors.secondary,
                        ),
                      ),
                      title: Text(
                        'Invoice #INV${1000 + index}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(customers[index]),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: statusColors[index].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  statuses[index],
                                  style: TextStyle(
                                    color: statusColors[index],
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${DateTime.now().subtract(Duration(days: index)).day} ${_getMonthName(DateTime.now().month)}',
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
                            FormatUtils.formatCurrency(500000 * (index + 1)),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                      onTap: () {
                        final invoice = {
                          'id': 'INV${1000 + index}',
                          'date': DateTime.now()
                              .subtract(Duration(days: index))
                              .toIso8601String(),
                          'customer': customers[index],
                          'status': statuses[index].toLowerCase(),
                          'total': 500000 * (index + 1),
                        };
                        context.push('/invoice-detail', extra: invoice);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return months[month - 1];
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();
  
  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Selamat Pagi';
    } else if (hour < 17) {
      greeting = 'Selamat Siang';
    } else {
      greeting = 'Selamat Malam';
    }

    return Card(
      // ignore: deprecated_member_use
      color: AppColors.primary.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.textLight,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Selamat datang kembali!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_active),
              color: AppColors.secondary,
              onPressed: () => context.push('/notifications'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final Color color;
  final bool isCount;
  final double? change;
  final bool isFeatured;
  final bool isFullWidth;
  final String? subtitle;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
    this.isCount = false,
    this.change,
    this.isFeatured = false,
    this.isFullWidth = false,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isFeatured ? 6 : 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isFeatured
            ? BorderSide(
                // ignore: deprecated_member_use
                color: color.withOpacity(0.3),
                width: 1.5,
              )
            : BorderSide.none,
      ),
      child: Container(
        width: isFullWidth ? double.infinity : null,
        constraints: const BoxConstraints(minHeight: 160),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: isFeatured
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  // ignore: deprecated_member_use
                  colors: [
                    // ignore: deprecated_member_use
                    color.withOpacity(0.3),
                    // ignore: deprecated_member_use
                    color.withOpacity(0.15),
                    // ignore: deprecated_member_use
                    color.withOpacity(0.08),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                )
              : null,
          // ignore: deprecated_member_use
          color: isFeatured
              ? null
              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
          // ignore: deprecated_member_use
          boxShadow: isFeatured
              ? [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: color.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                ]
              : [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: AppColors.primary.withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isFeatured ? 24 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header Section dengan icon lebih besar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title.toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: AppColors.primary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                // ignore: deprecated_member_use
                                color: AppColors.primary.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              subtitle!,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.all(isFeatured ? 18 : 16),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: color.withOpacity(isFeatured ? 0.4 : 0.2),
                      borderRadius: BorderRadius.circular(16),
                      // ignore: deprecated_member_use
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: color.withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: color, size: isFeatured ? 36 : 32),
                  ),
                ],
              ),
              // Amount Section - Lebih besar dan jelas
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCount
                        ? amount.toInt().toString()
                        : FormatUtils.formatCurrency(amount),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: isFeatured ? 34 : 30,
                      letterSpacing: -2,
                      height: 1.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (change != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color:
                            (change! > 0 ? AppColors.success : AppColors.error)
                            // ignore: deprecated_member_use
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          // ignore: deprecated_member_use
                          color:
                              (change! > 0
                                      ? AppColors.success
                                      : AppColors.error)
                                  // ignore: deprecated_member_use
                                  .withOpacity(0.5),
                          width: 2,
                        ),
                        // ignore: deprecated_member_use
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color:
                                (change! > 0
                                        ? AppColors.success
                                        : AppColors.error)
                                    // ignore: deprecated_member_use
                                    .withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color:
                                  (change! > 0
                                          ? AppColors.success
                                          : AppColors.error)
                                      // ignore: deprecated_member_use
                                      .withOpacity(0.25),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              change! > 0
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              size: 18,
                              color: change! > 0
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${change!.abs().toStringAsFixed(1)}%',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: change! > 0
                                      ? AppColors.success
                                      : AppColors.error,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'vs periode lalu',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
