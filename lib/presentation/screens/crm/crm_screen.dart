import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/format_utils.dart';
import '../../../core/widgets/empty_state.dart';
import '../../providers/customer_provider.dart';
import '../dialogs/add_customer_dialog.dart';
import 'customer_detail_screen.dart';

class CRMScreen extends ConsumerStatefulWidget {
  const CRMScreen({super.key});

  @override
  ConsumerState<CRMScreen> createState() => _CRMScreenState();
}
class _CustomerSearchDelegate extends SearchDelegate<Map<String, dynamic>?> {
  final List<Map<String, dynamic>> customers;

  _CustomerSearchDelegate(this.customers);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = customers.where((c) => (c['name'] as String).toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final c = results[index];
        return ListTile(
          title: Text(c['name'] as String),
          subtitle: Text(c['email'] as String),
          onTap: () => close(context, c),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = customers.where((c) => (c['name'] as String).toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final c = suggestions[index];
        return ListTile(
          title: Text(c['name'] as String),
          subtitle: Text(c['email'] as String),
          onTap: () => close(context, c),
        );
      },
    );
  }
}

class _CRMScreenState extends ConsumerState<CRMScreen> {
  String _segmentFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final customers = ref.watch(customerProvider);
    
    final filteredCustomers = _segmentFilter == 'all'
        ? customers
        : customers.where((c) => c['segment'] == _segmentFilter).toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
        title: const Text('Pelanggan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final result = await showSearch<Map<String, dynamic>?>(
                context: context,
                delegate: _CustomerSearchDelegate(customers),
              );
              if (result != null) {
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerDetailScreen(customer: result),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              final selected = await showModalBottomSheet<String>(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(title: const Text('Semua'), onTap: () => Navigator.pop(context, 'all')),
                    ListTile(title: const Text('VIP'), onTap: () => Navigator.pop(context, 'VIP')),
                    ListTile(title: const Text('Regular'), onTap: () => Navigator.pop(context, 'Regular')),
                    ListTile(title: const Text('New'), onTap: () => Navigator.pop(context, 'New')),
                  ],
                ),
              );
              if (selected != null) {
                setState(() {
                  _segmentFilter = selected;
                });
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: filteredCustomers.isEmpty
          ? EmptyState(
              icon: Icons.people,
              title: 'Belum Ada Pelanggan',
              message: 'Tambahkan pelanggan pertama Anda',
              actionLabel: 'Tambah Pelanggan',
              onAction: () {
                showDialog(
                  context: context,
                  builder: (context) => AddCustomerDialog(
                    onAdd: (customerData) {
                      ref.read(customerProvider.notifier).addCustomer(customerData);
                    },
                  ),
                );
              },
            )
            : Column(
              children: [
                // Segments
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SegmentCard(
                          label: 'VIP',
                          count: customers.where((c) => c['segment'] == 'VIP').length,
                          color: AppColors.warning,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SegmentCard(
                          label: 'Regular',
                          count: customers.where((c) => c['segment'] == 'Regular').length,
                          color: AppColors.info,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SegmentCard(
                          label: 'New',
                          count: customers.where((c) => c['segment'] == 'New').length,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Customer List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = filteredCustomers[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            // ignore: deprecated_member_use
                            backgroundColor: AppColors.secondary.withOpacity(0.1),
                            child: Text(
                              (customer['name'] as String)[0].toUpperCase(),
                              style: const TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            customer['name'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(customer['email'] as String),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Chip(
                                    label: Text(
                                      customer['segment'] as String,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    backgroundColor: _getSegmentColor(
                                      customer['segment'] as String,
                                    // ignore: deprecated_member_use
                                    ).withOpacity(0.1),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${customer['totalPurchase'] == null ? 0 : 1} pembelian',
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
                                  customer['totalPurchase'] as double? ?? 0,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustomerDetailScreen(
                                        customer: customer,
                                      ),
                                    ),
                                  );
                                },
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
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddCustomerDialog(
              onAdd: (customerData) {
                ref.read(customerProvider.notifier).addCustomer(customerData);
              },
            ),
          );
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Tambah Pelanggan'),
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

class _SegmentCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _SegmentCard({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
