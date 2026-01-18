import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Pastikan back button muncul
        title: const Text(AppConstants.appName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kebijakan Privasi',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 24),
            _Section(
              title: '1. Pengumpulan Data',
              content:
                  'Kami mengumpulkan informasi yang Anda berikan saat mendaftar dan menggunakan aplikasi STRAVIX.ID, termasuk nama, email, dan data bisnis Anda.',
            ),
            _Section(
              title: '2. Penggunaan Data',
              content:
                  'Data yang dikumpulkan digunakan untuk menyediakan dan meningkatkan layanan kami, memproses transaksi, dan mengirimkan notifikasi penting terkait akun Anda.',
            ),
            _Section(
              title: '3. Perlindungan Data',
              content:
                  'Kami menggunakan enkripsi dan langkah-langkah keamanan lainnya untuk melindungi data pribadi Anda dari akses yang tidak sah, perubahan, pengungkapan, atau penghancuran.',
            ),
            _Section(
              title: '4. Berbagi Data',
              content:
                  'Kami tidak menjual, memperdagangkan, atau mentransfer data pribadi Anda kepada pihak ketiga tanpa persetujuan Anda, kecuali sebagaimana dijelaskan dalam kebijakan ini.',
            ),
            _Section(
              title: '5. Hak Anda',
              content:
                  'Anda memiliki hak untuk mengakses, memperbarui, atau menghapus data pribadi Anda. Hubungi kami jika Anda ingin menggunakan hak-hak ini.',
            ),
            _Section(
              title: '6. Perubahan Kebijakan',
              content:
                  'Kami dapat memperbarui kebijakan privasi ini dari waktu ke waktu. Perubahan akan diberitahukan melalui aplikasi atau email.',
            ),
            const SizedBox(height: 32),
            Text(
              'Terakhir diperbarui: ${DateTime.now().year}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String content;

  const _Section({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
