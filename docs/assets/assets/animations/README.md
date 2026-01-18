# Assets - Animations

Folder ini berisi file animasi Lottie yang digunakan dalam aplikasi STRAVIX.ID.

## File yang Diperlukan:

### 1. Loading Animations
- `loading.json` - Animasi loading umum
- `loading_circle.json` - Animasi loading circular
- `loading_dots.json` - Animasi loading dots

### 2. Success/Error Animations
- `success.json` - Animasi sukses (untuk konfirmasi)
- `error.json` - Animasi error
- `warning.json` - Animasi warning

### 3. Empty States Animations
- `empty_products.json` - Animasi untuk empty state produk
- `empty_customers.json` - Animasi untuk empty state pelanggan
- `empty_invoices.json` - Animasi untuk empty state invoice

### 4. Onboarding Animations (Optional)
- `onboarding_business.json` - Animasi untuk onboarding bisnis
- `onboarding_analytics.json` - Animasi untuk onboarding analytics
- `onboarding_financial.json` - Animasi untuk onboarding keuangan

### 5. Splash Screen Animation (Optional)
- `splash_animation.json` - Animasi untuk splash screen

## Sumber Lottie Files:
- [LottieFiles.com](https://lottiefiles.com) - Download gratis animasi Lottie
- Cari dengan keyword: "loading", "success", "empty", dll
- Pilih yang sesuai dengan tema aplikasi (modern, professional)

## Format:
- Format: JSON (Lottie)
- Ukuran: Optimalkan (maks 200KB per file)

## Cara Menggunakan:
```dart
import 'package:lottie/lottie.dart';

Lottie.asset(
  'assets/animations/loading.json',
  width: 100,
  height: 100,
)
```

## Catatan:
- Saat ini aplikasi menggunakan Material Design loading indicators
- Folder ini untuk animasi custom jika diperlukan di masa depan
