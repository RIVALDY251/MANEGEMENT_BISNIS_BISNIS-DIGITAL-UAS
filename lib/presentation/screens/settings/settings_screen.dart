// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/business_switcher_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showBusinessSwitcher(BuildContext context) {
    final businesses = [
      {'id': '1', 'name': 'Toko Saya', 'address': 'Jl. Contoh No. 123'},
      {'id': '2', 'name': 'Outlet Cabang 1', 'address': 'Jl. Cabang No. 1'},
    ];

    showDialog(
      context: context,
      builder: (context) => BusinessSwitcherDialog(
        businesses: businesses,
        currentBusinessId: '1',
        onSwitch: (businessId) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Bisnis berhasil diganti')));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
        title: const Text(AppConstants.appName),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
          // Profile Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Profil', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: const Text('Nama Pengguna'),
                    subtitle: const Text('user@example.com'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/edit-profile');
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: const Text('Ubah Password'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/change-password');
                    },
                  ),
                ),
              ],
            ),
          ),
          // Business Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bisnis', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.business),
                    title: const Text('Profil Bisnis'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/business-profile');
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.swap_horiz),
                    title: const Text('Ganti Bisnis'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      _showBusinessSwitcher(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          // App Settings
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengaturan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Consumer(
                  builder: (context, ref, child) {
                    final settingsState = ref.watch(settingsProvider);
                    final settingsNotifier = ref.read(
                      settingsProvider.notifier,
                    );

                    return Card(
                      child: SwitchListTile(
                        secondary: const Icon(Icons.notifications),
                        title: const Text('Notifikasi'),
                        subtitle: const Text('Aktifkan notifikasi'),
                        value: settingsState.notificationsEnabled,
                        onChanged: (value) {
                          settingsNotifier.setNotificationsEnabled(value);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                value
                                    ? 'Notifikasi diaktifkan'
                                    : 'Notifikasi dinonaktifkan',
                              ),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Consumer(
                  builder: (context, ref, child) {
                    final settingsState = ref.watch(settingsProvider);
                    final settingsNotifier = ref.read(
                      settingsProvider.notifier,
                    );

                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.language),
                        title: const Text('Bahasa'),
                        subtitle: Text(
                          settingsNotifier.getLanguageLabel(
                            settingsState.language,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          _showLanguageDialog(context, ref);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Consumer(
                  builder: (context, ref, child) {
                    final themeState = ref.watch(themeProvider);
                    final themeNotifier = ref.read(themeProvider.notifier);

                    return Card(
                      child: ListTile(
                        leading: Icon(
                          themeState.themeMode == ThemeMode.dark
                              ? Icons.dark_mode
                              : themeState.themeMode == ThemeMode.light
                              ? Icons.light_mode
                              : Icons.brightness_auto,
                        ),
                        title: const Text('Tema'),
                        subtitle: Text(themeNotifier.getThemeModeLabel()),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          _showThemeDialog(context, ref);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Legal & Support
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bantuan & Dukungan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Kebijakan Privasi'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/privacy-policy');
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Syarat & Ketentuan'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/terms');
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text('Bantuan'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      _showHelpDialog(context);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Tentang Aplikasi'),
                    subtitle: Text('Versi ${AppConstants.appVersion}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      _showAboutDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Danger Zone
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zona Berbahaya',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppColors.error),
                ),
                const SizedBox(height: 16),
                Card(
                  // ignore: duplicate_ignore
                  // ignore: deprecated_member_use
                  color: AppColors.error.withOpacity(0.1),
                  child: ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                    ),
                    title: const Text(
                      'Hapus Akun',
                      style: TextStyle(color: AppColors.error),
                    ),
                    subtitle: const Text(
                      'Tindakan ini tidak dapat dibatalkan',
                      style: TextStyle(color: AppColors.error),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      _showDeleteAccountDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Logout
          Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer(
              builder: (context, ref, child) {
                return AppButton(
                  label: 'Keluar',
                  icon: Icons.logout,
                  type: AppButtonType.outline,
                  onPressed: () async {
                    await ref.read(authProvider.notifier).logout();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                  width: double.infinity,
                );
              },
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Tema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('Terang'),
              subtitle: const Text('Menggunakan tema terang'),
              value: ThemeMode.light,
              groupValue: themeState.themeMode,
              onChanged: (value) {
                if (value != null) {
                  themeNotifier.setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Gelap'),
              subtitle: const Text('Menggunakan tema gelap'),
              value: ThemeMode.dark,
              groupValue: themeState.themeMode,
              onChanged: (value) {
                if (value != null) {
                  themeNotifier.setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Sistem'),
              subtitle: const Text('Mengikuti pengaturan sistem'),
              value: ThemeMode.system,
              groupValue: themeState.themeMode,
              onChanged: (value) {
                if (value != null) {
                  themeNotifier.setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Bahasa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Indonesia'),
              value: 'id',
              groupValue: settingsState.language,
              onChanged: (value) {
                if (value != null) {
                  settingsNotifier.setLanguage(value);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bahasa berhasil diubah'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: settingsState.language,
              onChanged: (value) {
                if (value != null) {
                  settingsNotifier.setLanguage(value);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Language changed successfully'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bantuan'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pusat Bantuan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Jika Anda membutuhkan bantuan, silakan hubungi kami melalui:',
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.email, size: 20),
                  SizedBox(width: 8),
                  Text('support@stravix.id'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, size: 20),
                  SizedBox(width: 8),
                  Text('+62 812 3456 7890'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, size: 20),
                  SizedBox(width: 8),
                  Text('Senin - Jumat, 09:00 - 17:00 WIB'),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.appDisplayName,
      applicationVersion: AppConstants.appVersion,
      applicationIcon: const Icon(Icons.business, size: 48),
      children: [
        const SizedBox(height: 16),
        const Text(
          'Smart Platform for Business Growth',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'STRAVIX.ID adalah platform digital untuk membantu UMKM mengelola bisnis mereka dengan lebih efisien dan efektif.',
        ),
        const SizedBox(height: 16),
        const Text(
          '© 2024 STRAVIX.ID. All rights reserved.',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Akun'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus akun? Tindakan ini tidak dapat dibatalkan dan semua data akan dihapus permanen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              // Show loading
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );

              // Simulate delete account
              await Future.delayed(const Duration(seconds: 2));

              if (!context.mounted) return;
              Navigator.pop(context); // Close loading

              // Logout and redirect to login
              final ref = ProviderScope.containerOf(context);
              await ref.read(authProvider.notifier).logout();

              if (context.mounted) {
                context.go('/login');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Akun berhasil dihapus'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
