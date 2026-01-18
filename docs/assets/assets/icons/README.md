# Assets - Icons

Folder ini berisi icon-icon custom yang digunakan dalam aplikasi STRAVIX.ID.

## File yang Diperlukan:

### 1. App Icons
- `app_icon.png` - Icon aplikasi (1024x1024) untuk Play Store
- `app_icon_adaptive.png` - Icon adaptive untuk Android

### 2. Feature Icons (Optional - jika tidak menggunakan Material Icons)
- `icon_dashboard.svg` - Icon dashboard
- `icon_products.svg` - Icon produk
- `icon_customers.svg` - Icon pelanggan
- `icon_invoices.svg` - Icon invoice
- `icon_financial.svg` - Icon keuangan
- `icon_analytics.svg` - Icon analytics
- `icon_settings.svg` - Icon settings

### 3. Status Icons
- `icon_success.svg` - Icon sukses
- `icon_error.svg` - Icon error
- `icon_warning.svg` - Icon warning
- `icon_info.svg` - Icon informasi

## Catatan:
- Aplikasi STRAVIX.ID saat ini menggunakan Material Icons dari Flutter
- Folder ini untuk icon custom jika diperlukan di masa depan
- Format yang disarankan: SVG untuk scalability

## Cara Menggunakan:
```dart
// Jika menggunakan SVG
SvgPicture.asset('assets/icons/icon_dashboard.svg')

// Jika menggunakan PNG
Image.asset('assets/icons/app_icon.png')
```
