import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Stok Rendah',
      'message': 'Produk A memiliki stok di bawah 20 unit. Segera lakukan restock.',
      'type': 'stock',
      'icon': Icons.inventory_2,
      'color': AppColors.warning,
      'time': '2 jam yang lalu',
      'isRead': false,
    },
    {
      'id': '2',
      'title': 'Insight Mingguan',
      'message': 'Laporan performa bisnis minggu ini sudah tersedia. Lihat sekarang!',
      'type': 'insight',
      'icon': Icons.insights,
      'color': AppColors.info,
      'time': '1 hari yang lalu',
      'isRead': false,
    },
    {
      'id': '3',
      'title': 'Invoice Dibayar',
      'message': 'Invoice #INV001 telah dibayar oleh Pelanggan A',
      'type': 'payment',
      'icon': Icons.payment,
      'color': AppColors.success,
      'time': '2 hari yang lalu',
      'isRead': true,
    },
    {
      'id': '4',
      'title': 'Peringatan Cashflow',
      'message': 'Pengeluaran bulan ini sudah mencapai 80% dari pendapatan',
      'type': 'alert',
      'icon': Icons.warning,
      'color': AppColors.error,
      'time': '3 hari yang lalu',
      'isRead': true,
    },
  ];

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n['id'] == id);
      if (index != -1) {
        _notifications[index]['isRead'] = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Pastikan back button muncul
        title: const Text(AppConstants.appName),
        actions: [
          if (_notifications.any((n) => !n['isRead']))
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text('Tandai Semua Dibaca'),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? EmptyState(
              icon: Icons.notifications_none,
              title: 'Tidak Ada Notifikasi',
              message: 'Anda tidak memiliki notifikasi baru',
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
                          label: 'Total',
                          value: _notifications.length.toString(),
                          icon: Icons.notifications,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.borderLight,
                      ),
                      Expanded(
                        child: _SummaryItem(
                          label: 'Belum Dibaca',
                          value: _notifications
                              .where((n) => !n['isRead'])
                              .length
                              .toString(),
                          icon: Icons.notifications_active,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
                // Notifications List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      final isRead = notification['isRead'] as bool;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        color: isRead
                            ? null
                            // ignore: deprecated_member_use
                            : AppColors.secondary.withOpacity(0.05),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (notification['color'] as Color)
                                  // ignore: deprecated_member_use
                                  .withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              notification['icon'] as IconData,
                              color: notification['color'] as Color,
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  notification['title'] as String,
                                  style: TextStyle(
                                    fontWeight: isRead
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (!isRead)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(notification['message'] as String),
                              const SizedBox(height: 4),
                              Text(
                                notification['time'] as String,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _notifications.removeAt(index);
                              });
                            },
                          ),
                          onTap: () {
                            _markAsRead(notification['id'] as String);
                            // Navigate to detail if needed
                          },
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

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color ?? AppColors.secondary),
        const SizedBox(width: 8),
        Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
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
