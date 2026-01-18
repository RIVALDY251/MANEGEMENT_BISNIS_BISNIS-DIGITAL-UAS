# Assets - Fonts

Folder ini berisi file font yang digunakan dalam aplikasi STRAVIX.ID.

## File yang Diperlukan:

### 1. Inter Font Family
- `Inter-Regular.ttf` (weight: 400) - Untuk body text
- `Inter-Medium.ttf` (weight: 500) - Untuk medium text
- `Inter-SemiBold.ttf` (weight: 600) - Untuk heading
- `Inter-Bold.ttf` (weight: 700) - Untuk bold text

### 2. Poppins Font Family (Alternatif)
- `Poppins-Regular.ttf` (weight: 400)
- `Poppins-Medium.ttf` (weight: 500)
- `Poppins-SemiBold.ttf` (weight: 600)
- `Poppins-Bold.ttf` (weight: 700)

## Sumber Font:
- **Inter**: [Google Fonts](https://fonts.google.com/specimen/Inter) - Download gratis
- **Poppins**: [Google Fonts](https://fonts.google.com/specimen/Poppins) - Download gratis

## Cara Download:
1. Kunjungi Google Fonts
2. Pilih font (Inter atau Poppins)
3. Download font family
4. Extract file .ttf
5. Copy ke folder `assets/fonts/`

## Konfigurasi:
Font sudah dikonfigurasi di `pubspec.yaml`. Pastikan nama file sesuai dengan konfigurasi.

## Catatan:
- Saat ini aplikasi menggunakan Google Fonts (Inter/Poppins) via package
- File font lokal diperlukan jika ingin offline support atau custom font
- Jika menggunakan Google Fonts package, folder ini bisa kosong

## Status:
✅ Konfigurasi sudah ada di pubspec.yaml
⚠️ File font belum di-download (bisa menggunakan Google Fonts package sebagai alternatif)
