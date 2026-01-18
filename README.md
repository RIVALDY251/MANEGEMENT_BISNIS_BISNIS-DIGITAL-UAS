# STRAVIX.ID

**Smart Platform for Business Growth**

Digital Business Operating System (SaaS UMKM) - Aplikasi mobile Flutter production-ready untuk mengelola bisnis UMKM secara komprehensif.

## 📱 Tentang Aplikasi

STRAVIX.ID adalah platform SaaS lengkap yang dirancang khusus untuk membantu UMKM mengelola semua aspek bisnis mereka dalam satu aplikasi. Dari manajemen keuangan hingga analitik bisnis dengan AI insights.

## ✨ Fitur Utama

### 1. Authentication & Security
- Login, Register, Logout
- Email verification
- Forgot password
- Role-based access control

### 2. Business Profile & Multi-Business
- Profil bisnis lengkap
- Multi outlet management
- Switch business dengan mudah

### 3. Financial Management
- Pemasukan & pengeluaran tracking
- Cashflow monitoring
- Laporan laba rugi
- Export PDF / Excel

### 4. Product & Inventory
- CRUD produk lengkap
- Manajemen stok real-time
- Riwayat transaksi produk

### 5. CRM (Customer Relationship Management)
- Data pelanggan terpusat
- Riwayat pembelian
- Segmentasi pelanggan (VIP, Regular, New)

### 6. Invoice & Payment
- Generate invoice otomatis
- Status pembayaran tracking
- Download invoice PDF

### 7. Analytics Dashboard
- Grafik pendapatan interaktif
- Produk terlaris
- Ringkasan performa bisnis

### 8. AI Business Insight
- Insight otomatis dari data
- Rekomendasi bisnis
- Prediksi sederhana

### 9. Notification System
- Reminder stok rendah
- Insight mingguan

### 10. Settings & Compliance
- Profile management
- Change password
- Privacy Policy
- Terms & Conditions
- Account deletion

## 🎨 Design System

### Color Palette
- **Primary**: Navy Blue #0F172A
- **Secondary**: Emerald Green #10B981
- **Background Light**: #F8FAFC
- **Background Dark**: #020617
- **Text Primary**: #0F172A
- **Text Secondary**: #64748B

### Typography
- Font Family: Inter / Poppins
- Heading: SemiBold
- Body: Regular

## 🏗️ Arsitektur

Aplikasi ini menggunakan **Clean Architecture** dengan struktur:

```
lib/
├── core/
│   ├── constants/      # App constants
│   ├── theme/          # Theme & colors
│   ├── utils/          # Utility functions
│   ├── widgets/        # Reusable widgets
│   └── routing/        # Navigation setup
├── data/
│   ├── datasources/    # Data sources (API, Local)
│   ├── models/         # Data models
│   └── repositories/   # Repository implementations
├── domain/
│   ├── entities/       # Business entities
│   ├── repositories/   # Repository interfaces
│   └── usecases/       # Business logic
└── presentation/
    ├── providers/      # Riverpod providers
    ├── screens/        # UI screens
    └── widgets/        # Screen-specific widgets
```

## 🛠️ Tech Stack

- **Flutter** (stable)
- **Material Design 3**
- **Riverpod** (State Management)
- **GoRouter** (Navigation)
- **Clean Architecture**
- **Dependency Injection**

## 📦 Dependencies Utama

- `flutter_riverpod` - State management
- `go_router` - Navigation
- `fl_chart` - Charts & graphs
- `pdf` & `excel` - Export functionality
- `shared_preferences` - Local storage
- `google_fonts` - Typography
- `shimmer` - Loading animations

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK
- Android Studio / VS Code
- Android SDK / Xcode (untuk iOS)

### Installation

1. Clone repository
```bash
git clone <repository-url>
cd bisnis_digital_uas_projeck
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

### Build for Production

#### Android
```bash
flutter build apk --release
# atau
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

## 📱 Package Information

- **Package Name**: `com.stravix.id`
- **App Display Name**: `Stravix.ID`
- **Version**: 1.0.0+1

## 🎯 Fitur UI/UX

- ✅ Splash screen dengan logo STRAVIX.ID + fade animation
- ✅ Hero animation (logo → dashboard)
- ✅ Page transition (slide & fade)
- ✅ Ripple effect pada button
- ✅ Skeleton loader & shimmer effect
- ✅ Empty state & error state profesional
- ✅ Material Design 3 components

## 📄 License

This project is private and proprietary.

## 👥 Development

Aplikasi ini siap untuk dikembangkan lebih lanjut dengan integrasi backend API. Semua struktur sudah disiapkan untuk:

- API integration
- Real-time data sync
- Push notifications
- Offline support
- Advanced analytics

## 🔄 Next Steps

1. Integrasi dengan backend API
2. Implementasi real-time sync
3. Push notifications setup
4. Advanced AI insights
5. Multi-language support
6. Dark mode improvements

---

**STRAVIX.ID** - Smart Platform for Business Growth 🚀
