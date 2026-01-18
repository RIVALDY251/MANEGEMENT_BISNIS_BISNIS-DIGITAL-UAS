import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BusinessSwitcherDialog extends StatelessWidget {
  final List<Map<String, dynamic>> businesses;
  final String currentBusinessId;
  final Function(String) onSwitch;

  const BusinessSwitcherDialog({
    super.key,
    required this.businesses,
    required this.currentBusinessId,
    required this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Bisnis',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Pilih bisnis yang ingin Anda aktifkan',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ...businesses.map((business) {
              final isSelected = business['id'] == currentBusinessId;
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: isSelected
                    // ignore: deprecated_member_use
                    ? AppColors.secondary.withOpacity(0.1)
                    : null,
                child: ListTile(
                  leading: Icon(
                    Icons.business,
                    color: isSelected ? AppColors.secondary : AppColors.textSecondary,
                  ),
                  title: Text(
                    business['name'] as String,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(business['address'] as String? ?? ''),
                  trailing: isSelected
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.secondary,
                        )
                      : null,
                  onTap: () {
                    onSwitch(business['id'] as String);
                    Navigator.pop(context);
                  },
                ),
              );
            }),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () async {
                final result = await showDialog<Map<String, String>?>(
                  context: context,
                  builder: (context) {
                    final nameCtrl = TextEditingController();
                    final addressCtrl = TextEditingController();
                    return AlertDialog(
                      title: const Text('Tambah Bisnis Baru'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nama Bisnis')),
                          TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: 'Alamat')),
                        ],
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                        TextButton(onPressed: () => Navigator.pop(context, {'name': nameCtrl.text, 'address': addressCtrl.text}), child: const Text('Tambah')),
                      ],
                    );
                  },
                );
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                if (result != null && (result['name']?.isNotEmpty ?? false)) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fitur tambah bisnis: berhasil (placeholder)')));
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Tambah Bisnis Baru'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
