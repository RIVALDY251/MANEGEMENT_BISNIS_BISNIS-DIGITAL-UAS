# 📦 Panduan Lengkap Assets STRAVIX.ID

Dokumen ini menjelaskan semua file yang diperlukan di folder `assets/` untuk aplikasi STRAVIX.ID.

## ⚡ STATUS SAAT INI: SIAP UNTUK DEMO/LAPORAN

✅ **Aplikasi sudah bisa dijalankan tanpa file assets!**

- Aplikasi menggunakan **Material Icons** untuk semua icon/logo
- Font menggunakan **Google Fonts** (download otomatis)
- Animasi menggunakan **flutter_animate** (built-in, tidak perlu file JSON)
- **Tidak ada error kompilasi** - semua dependencies sudah terpasang

**Untuk demo/laporan ke dosen**: Aplikasi bisa langsung dijalankan dengan `flutter run`

**Untuk production nanti**: Bisa ditambahkan logo, app icon, dan animasi custom sesuai kebutuhan.

## 📁 Struktur Folder

```
assets/
├── animations/     # File animasi Lottie (.json)
├── fonts/          # File font (.ttf)
├── icons/          # Icon custom (.svg, .png)
└── images/         # Gambar aplikasi (.png, .svg)
```

---

## 🎨 1. FOLDER: `assets/images/`

### **PRIORITAS TINGGI** (Wajib untuk Production):
- ✅ `logo.png` / `logo.svg` - Logo STRAVIX.ID
- ✅ `logo_white.png` - Logo untuk dark mode
- ✅ `placeholder_product.png` - Placeholder produk

### **PRIORITAS SEDANG** (Sangat Disarankan):
- 📸 `onboarding_1.png` - Gambar onboarding
- 📸 `onboarding_2.png` - Gambar onboarding
- 📸 `onboarding_3.png` - Gambar onboarding
- 📸 `empty_products.png` - Empty state
- 📸 `empty_customers.png` - Empty state

### **PRIORITAS RENDAH** (Opsional):
- 🖼️ `error_network.png` - Error state
- 🖼️ `placeholder_user.png` - Avatar placeholder

**Total Estimasi**: 8-10 file gambar

---

## 🎭 2. FOLDER: `assets/animations/`

### **PRIORITAS TINGGI**:
- ✅ `loading.json` - Animasi loading

### **PRIORITAS SEDANG**:
- 🎬 `success.json` - Animasi sukses
- 🎬 `error.json` - Animasi error
- 🎬 `empty_products.json` - Empty state animation

### **PRIORITAS RENDAH**:
- 🎬 `splash_animation.json` - Splash screen animation

**Sumber**: [LottieFiles.com](https://lottiefiles.com) - Download gratis

**Total Estimasi**: 3-5 file animasi

---

## 🎯 3. FOLDER: `assets/icons/`

### **PRIORITAS TINGGI**:
- ✅ `app_icon.png` (1024x1024) - Icon untuk Play Store

### **PRIORITAS RENDAH**:
- 🎨 Icon custom lainnya (opsional, karena sudah pakai Material Icons)

**Total Estimasi**: 1 file (app icon)

---

## 🔤 4. FOLDER: `assets/fonts/`

### **Status**: 
- ⚠️ **OPSIONAL** - Aplikasi sudah menggunakan Google Fonts package
- Jika ingin offline support, download font dari Google Fonts:
  - Inter: Regular, Medium, SemiBold, Bold
  - Poppins: Regular, Medium, SemiBold, Bold

**Total Estimasi**: 8 file font (jika ingin offline support)

---

## 📋 CHECKLIST PERSIAPAN PRODUCTION

### Minimal untuk Launch:
- [ ] Logo aplikasi (`logo.png`)
- [ ] App icon (`app_icon.png` - 1024x1024)
- [ ] Loading animation (`loading.json`)
- [ ] Placeholder images (minimal 1-2 file)

### Lengkap untuk Production:
- [ ] Semua file di "PRIORITAS TINGGI"
- [ ] Semua file di "PRIORITAS SEDANG"
- [ ] Font files (jika ingin offline support)

---

## 🚀 Quick Start

### 1. Logo & App Icon (PENTING!)
```bash
# Buat logo STRAVIX.ID dengan:
# - Ukuran: 1024x1024px untuk app icon
# - Format: PNG dengan transparansi
# - Warna: Sesuai brand (Navy Blue #0F172A, Emerald Green #10B981)
```

### 2. Download Animations
1. Kunjungi [LottieFiles.com](https://lottiefiles.com)
2. Search: "loading", "success", "empty"
3. Download format JSON
4. Simpan di `assets/animations/`

### 3. Download Fonts (Opsional)
1. Kunjungi [Google Fonts](https://fonts.google.com)
2. Download Inter & Poppins
3. Extract .ttf files
4. Simpan di `assets/fonts/`

---

## 💡 Tips

1. **Optimasi File**:
   - Kompres gambar sebelum digunakan
   - Gunakan SVG untuk logo/icon jika memungkinkan
   - Animasi Lottie biasanya sudah optimized

2. **Naming Convention**:
   - Gunakan lowercase dengan underscore: `logo_app.png`
   - Konsisten dengan naming: `empty_products.png` bukan `emptyProducts.png`

3. **Ukuran File**:
   - Gambar: Maks 500KB per file
   - Animasi: Maks 200KB per file
   - Font: Maks 500KB per file

---

## 📝 Catatan Penting

- ✅ Konfigurasi assets sudah ada di `pubspec.yaml`
- ✅ Aplikasi bisa berjalan tanpa assets (menggunakan placeholder)
- ⚠️ Untuk production, minimal perlu logo dan app icon
- 📦 Semua file akan di-bundle ke dalam APK/IPA

---

**Last Updated**: Sekarang
**Status**: Ready untuk diisi assets
