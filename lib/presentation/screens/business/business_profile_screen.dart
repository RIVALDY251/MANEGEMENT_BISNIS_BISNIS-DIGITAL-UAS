import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../widgets/business_switcher_dialog.dart';
import '../../../core/widgets/app_back_button.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Toko Saya');
  final _emailController = TextEditingController(text: 'toko@example.com');
  final _phoneController = TextEditingController(text: '+628123456789');
  final _addressController = TextEditingController(text: 'Jl. Contoh No. 123');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _showBusinessSwitcher(BuildContext context) {
    final businesses = [
      {
        'id': '1',
        'name': _nameController.text,
        'address': _addressController.text,
      },
      {
        'id': '2',
        'name': 'Outlet Cabang 1',
        'address': 'Jl. Cabang No. 1',
      },
    ];

    showDialog(
      context: context,
      builder: (context) => BusinessSwitcherDialog(
        businesses: businesses,
        currentBusinessId: '1',
        onSwitch: (businessId) {
          // Switch business logic
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Bisnis berhasil diganti')),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(AppConstants.appName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Business Switch
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.business, size: 40),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bisnis Aktif',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              _nameController.text,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.swap_horiz),
                        onPressed: () {
                          _showBusinessSwitcher(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Informasi Bisnis',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Nama Bisnis',
                controller: _nameController,
                prefixIcon: const Icon(Icons.business),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Telepon',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Alamat',
                controller: _addressController,
                maxLines: 3,
                prefixIcon: const Icon(Icons.location_on),
              ),
              const SizedBox(height: 32),
              AppButton(
                label: 'Simpan Perubahan',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profil bisnis berhasil diperbarui')),
                  );
                },
                width: double.infinity,
              ),
              const SizedBox(height: 24),
              // Multi Business Section
              Text(
                'Multi Outlet',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.add_business),
                  title: const Text('Tambah Outlet Baru'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    final result = await showDialog<Map<String, String>?>(
                      context: context,
                      builder: (context) {
                        final nameCtrl = TextEditingController();
                        final addressCtrl = TextEditingController();
                        return AlertDialog(
                          title: const Text('Tambah Outlet'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nama Outlet')),
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
                    if (result != null && (result['name']?.isNotEmpty ?? false)) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Outlet berhasil ditambahkan')));
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.store),
                  title: const Text('Outlet Cabang 1'),
                  subtitle: const Text('Jl. Cabang No. 1'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showBusinessSwitcher(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
