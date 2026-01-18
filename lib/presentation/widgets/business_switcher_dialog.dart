import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Dialog untuk memilih dan mengelola bisnis yang aktif
/// Memungkinkan user untuk switch antar bisnis atau menambah bisnis baru
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
              final businessName = business['name'] as String? ?? 'Unnamed Business';
              final businessAddress = business['address'] as String? ?? '';
              
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
                    businessName,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: businessAddress.isNotEmpty ? Text(businessAddress) : null,
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
                    return _AddBusinessDialog();
                  },
                );
                // ignore: use_build_context_synchronously
                if (!context.mounted) return;
                Navigator.pop(context);
                
                if (result != null && (result['name']?.isNotEmpty ?? false)) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Bisnis "${result['name']}" berhasil ditambahkan'),
                      backgroundColor: AppColors.success,
                    ),
                  );
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

/// Dialog untuk menambah bisnis baru
class _AddBusinessDialog extends StatefulWidget {
  @override
  State<_AddBusinessDialog> createState() => _AddBusinessDialogState();
}

class _AddBusinessDialogState extends State<_AddBusinessDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Bisnis Baru'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nama Bisnis',
              hintText: 'Masukkan nama bisnis',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Alamat',
              hintText: 'Masukkan alamat bisnis',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _nameController.text.isEmpty
              ? null
              : () => Navigator.pop(
                    context,
                    {
                      'name': _nameController.text.trim(),
                      'address': _addressController.text.trim(),
                    },
                  ),
          child: const Text('Tambah'),
        ),
      ],
    );
  }
}
