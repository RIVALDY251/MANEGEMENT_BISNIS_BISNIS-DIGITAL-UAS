# Assets - Images

Folder ini berisi semua gambar yang digunakan dalam aplikasi STRAVIX.ID.

## File yang Diperlukan:

### 1. Logo & Branding
- `logo.png` / `logo.svg` - Logo utama STRAVIX.ID (untuk splash screen, AppBar)
- `logo_white.png` - Logo versi putih (untuk dark mode)
- `logo_icon.png` - Icon aplikasi (untuk launcher)

### 2. Onboarding Images
- `onboarding_1.png` - Gambar untuk onboarding page 1 (Kelola Bisnis)
- `onboarding_2.png` - Gambar untuk onboarding page 2 (Analisis & Insight)
- `onboarding_3.png` - Gambar untuk onboarding page 3 (Manajemen Keuangan)

### 3. Placeholder Images
- `placeholder_product.png` - Placeholder untuk produk tanpa gambar
- `placeholder_user.png` - Placeholder untuk avatar user
- `placeholder_business.png` - Placeholder untuk logo bisnis

### 4. Empty States
- `empty_products.png` - Gambar untuk empty state produk
- `empty_customers.png` - Gambar untuk empty state pelanggan
- `empty_invoices.png` - Gambar untuk empty state invoice
- `empty_transactions.png` - Gambar untuk empty state transaksi

### 5. Error States
- `error_network.png` - Gambar untuk error network
- `error_generic.png` - Gambar untuk error umum

## Format yang Disarankan:
- Format: PNG (dengan transparansi) atau SVG
- Resolusi: 2x atau 3x untuk retina displays
- Ukuran: Optimalkan untuk mobile (maks 500KB per file)

## Cara Menggunakan:
```dart
Image.asset('assets/images/logo.png')
```
