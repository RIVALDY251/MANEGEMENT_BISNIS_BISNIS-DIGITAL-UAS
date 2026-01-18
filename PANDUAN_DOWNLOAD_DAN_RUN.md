# 📱 STRAVIX - Panduan Download & Setup Aplikasi

Berikut adalah panduan lengkap untuk mendownload dan menjalankan aplikasi STRAVIX.

---

## **🚀 Quick Start (3 Langkah)**

### **Langkah 1: Clone Repository**
```bash
git clone https://github.com/RIVALDY251/MANEGEMENT_BISNIS_BISNIS-DIGITAL-UAS.git
cd MANEGEMENT_BISNIS_BISNIS-DIGITAL-UAS
```

### **Langkah 2: Install Dependencies**
```bash
flutter pub get
```

### **Langkah 3: Run Aplikasi**

**Option A: Jalankan di Web Browser (Chrome)**
```bash
flutter run -d chrome
```

**Option B: Jalankan di Android**
```bash
flutter run -d android
```

**Option C: Jalankan di iOS**
```bash
flutter run -d ios
```

---

## **📋 Persyaratan Sistem**

### **Untuk Semua Platform:**
- ✅ Git (untuk clone repository)
- ✅ Flutter SDK (versi terbaru)
- ✅ Dart SDK (sudah included dengan Flutter)

### **Untuk Web (Chrome):**
- ✅ Chrome browser installed
- ✅ Tidak perlu Android SDK atau Xcode

### **Untuk Android:**
- ✅ Android Studio atau Android SDK
- ✅ Android device/emulator
- ✅ Minimum Android 6.0 (API level 21)

### **Untuk iOS:**
- ✅ macOS
- ✅ Xcode
- ✅ iOS device/simulator

---

## **📥 Cara Download**

### **Method 1: Menggunakan Git (Recommended)**

1. **Buka Terminal/Command Prompt**
   - Windows: Tekan `Win + R`, ketik `cmd`, enter
   - macOS: Buka Applications → Utilities → Terminal
   - Linux: Buka Terminal

2. **Clone Repository**
   ```bash
   git clone https://github.com/RIVALDY251/MANEGEMENT_BISNIS_BISNIS-DIGITAL-UAS.git
   ```

3. **Masuk ke Folder Project**
   ```bash
   cd MANEGEMENT_BISNIS_BISNIS-DIGITAL-UAS
   ```

### **Method 2: Download Manual (ZIP)**

1. Kunjungi: **https://github.com/RIVALDY251/MANEGEMENT_BISNIS_BISNIS-DIGITAL-UAS**
2. Klik tombol **"Code"** (hijau) → **"Download ZIP"**
3. Extract file ZIP ke folder pilihan Anda
4. Buka Command Prompt di folder tersebut

---

## **⚙️ Setup Flutter**

Jika belum punya Flutter SDK, ikuti langkah berikut:

### **Windows:**
1. Download Flutter dari: https://flutter.dev/docs/get-started/install/windows
2. Extract ke folder (contoh: `C:\flutter`)
3. Tambahkan ke PATH:
   - Klik Windows button → cari "environment"
   - Edit system environment variables
   - Tambahkan `C:\flutter\bin` ke PATH
4. Buka Command Prompt baru dan ketik:
   ```bash
   flutter doctor
   ```

### **macOS:**
```bash
brew install flutter
```

### **Linux:**
```bash
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin"
```

---

## **🔧 Setup Dependencies**

```bash
# Check Flutter installation
flutter doctor

# Get dependencies
flutter pub get

# Upgrade dependencies (optional)
flutter pub upgrade
```

---

## **▶️ Menjalankan Aplikasi**

### **1️⃣ Run di Web Browser (PALING MUDAH)**

```bash
flutter run -d chrome
```

**Keuntungan:**
- ✅ Paling mudah & cepat
- ✅ Tidak perlu emulator/device
- ✅ Berjalan langsung di Chrome
- ✅ Hot reload built-in

### **2️⃣ Run di Android**

**Menggunakan Emulator:**
```bash
# List emulators
flutter emulators

# Jalankan emulator
flutter emulators --launch emulator_name

# Run app
flutter run
```

**Menggunakan Android Device:**
```bash
# Enable USB Debugging di device
# Connect via USB

# List devices
flutter devices

# Run
flutter run -d device_id
```

### **3️⃣ Run di iOS (macOS only)**

```bash
flutter run -d iphone
```

---

## **📱 Fitur Aplikasi**

✅ **Dashboard** - Ringkasan keuangan dengan visual yang menarik  
✅ **Financial Management** - Cashflow, Profit/Loss, Financial Reports  
✅ **Inventory** - Manajemen produk & stock tracking  
✅ **CRM** - Kelola customer & data bisnis  
✅ **Invoice** - Buat & manage invoice dengan PDF export  
✅ **Reports** - Export laporan PDF & Excel  
✅ **Responsive** - Support Web, Android, iOS  

---

## **⌨️ Keyboard Shortcuts (saat develop)**

Ketika aplikasi running:

| Key | Action |
|-----|--------|
| `r` | Hot reload |
| `R` | Hot restart |
| `h` | Tampilkan help |
| `q` | Quit aplikasi |
| `d` | Detach (tutup console tapi app tetap berjalan) |

---

## **🐛 Troubleshooting**

### **Error: "flutter: command not found"**
- **Solusi:** Tambahkan Flutter ke PATH environment variable

### **Error: "No devices found"**
```bash
# Check devices
flutter devices

# Untuk emulator Android, launch terlebih dahulu
flutter emulators --launch emulator_name
```

### **Error: "Gradle build failed"**
```bash
# Clean gradle
cd android
./gradlew clean
cd ..

# Run kembali
flutter run
```

### **Error: "CocoaPods not installed" (macOS/iOS)**
```bash
sudo gem install cocoapods
flutter pub get
```

### **Error: Dependencies error**
```bash
# Clean semua
flutter clean

# Get dependencies baru
flutter pub get

# Run kembali
flutter run -d chrome
```

---

## **📚 Struktur Project**

```
lib/
├── main.dart                 # Entry point
├── core/                     # Core functionality
│   ├── theme/               # Theme & colors
│   ├── routing/             # App routing
│   ├── utils/               # Utility functions
│   └── widgets/             # Reusable widgets
├── data/                     # Data layer
│   ├── datasources/         # Data sources
│   ├── models/              # Data models
│   └── repositories/        # Repository implementations
├── domain/                   # Business logic
│   ├── entities/            # Entities
│   ├── repositories/        # Repository contracts
│   └── usecases/            # Use cases
└── presentation/             # UI layer
    ├── screens/             # Screen pages
    ├── widgets/             # Custom widgets
    └── providers/           # State management (Riverpod)
```

---

## **🎨 Customization**

### **Mengubah Warna Theme**
Edit file: `lib/core/theme/app_colors.dart`

### **Mengubah Font**
Edit file: `pubspec.yaml` (fonts section)

### **Mengubah App Name**
- **Android:** `android/app/src/main/AndroidManifest.xml`
- **iOS:** `ios/Runner/Info.plist`
- **Web:** `web/index.html`

---

## **📝 Development Tips**

### **Hot Reload vs Hot Restart**
- **Hot Reload** (`r`): Update UI changes saja, state tetap
- **Hot Restart** (`R`): Full rebuild, state reset

### **Debug Build**
```bash
flutter run --debug
```

### **Release Build**
```bash
# Web
flutter build web

# Android APK
flutter build apk

# iOS
flutter build ios
```

---

## **🚀 Build untuk Production**

### **Web**
```bash
flutter build web --release
# Output di: build/web/
```

### **Android APK**
```bash
flutter build apk --release
# Output di: build/app/outputs/flutter-apk/app-release.apk
```

### **Android AppBundle**
```bash
flutter build appbundle --release
# Output di: build/app/outputs/bundle/release/app-release.aab
```

### **iOS**
```bash
flutter build ios --release
```

---

## **📞 Support**

- **GitHub Issues:** https://github.com/RIVALDY251/MANEGEMENT_BISNIS_BISNIS-DIGITAL-UAS/issues
- **Flutter Docs:** https://flutter.dev/docs
- **Dart Docs:** https://dart.dev/guides

---

## **✅ Checklist Sebelum Share**

Sebelum share dengan teman, pastikan:

- ✅ Repository sudah di-push ke GitHub
- ✅ README.md sudah ada
- ✅ `.gitignore` configured properly
- ✅ Semua dependencies listed di pubspec.yaml
- ✅ Code sudah di-test di multiple platforms
- ✅ PANDUAN_DOWNLOAD_DAN_RUN.md sudah ada (file ini!)

---

## **Happy Coding! 🎉**

Jika ada pertanyaan, bisa langsung create issue di GitHub repository atau tanya ke developer!

