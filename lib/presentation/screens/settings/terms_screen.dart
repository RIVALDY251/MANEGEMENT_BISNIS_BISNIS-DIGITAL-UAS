import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

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
              'Syarat & Ketentuan',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 24),
            _Section(
              title: '1. Penerimaan Syarat',
              content:
                  'Dengan menggunakan aplikasi STRAVIX.ID, Anda menyetujui untuk terikat oleh syarat dan ketentuan ini. Jika Anda tidak setuju, jangan gunakan aplikasi ini.',
            ),
            _Section(
              title: '2. Penggunaan Aplikasi',
              content:
                  'Anda setuju untuk menggunakan aplikasi hanya untuk tujuan yang sah dan sesuai dengan semua hukum dan peraturan yang berlaku. Anda tidak boleh menggunakan aplikasi untuk tujuan ilegal atau tidak sah.',
            ),
            _Section(
              title: '3. Akun Pengguna',
              content:
                  'Anda bertanggung jawab untuk menjaga kerahasiaan informasi akun Anda dan untuk semua aktivitas yang terjadi di bawah akun Anda. Segera beri tahu kami jika Anda mencurigai penggunaan yang tidak sah.',
            ),
            _Section(
              title: '4. Konten Pengguna',
              content:
                  'Anda mempertahankan semua hak atas konten yang Anda unggah ke aplikasi. Dengan mengunggah konten, Anda memberikan kami lisensi untuk menggunakan, menampilkan, dan mendistribusikan konten tersebut dalam aplikasi.',
            ),
            _Section(
              title: '5. Batasan Tanggung Jawab',
              content:
                  'Kami tidak bertanggung jawab atas kerugian langsung, tidak langsung, insidental, atau konsekuensial yang timbul dari penggunaan atau ketidakmampuan untuk menggunakan aplikasi.',
            ),
            _Section(
              title: '6. Perubahan Syarat',
              content:
                  'Kami berhak untuk mengubah syarat dan ketentuan ini kapan saja. Perubahan akan diberitahukan melalui aplikasi. Penggunaan berkelanjutan setelah perubahan berarti Anda menerima syarat baru.',
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
