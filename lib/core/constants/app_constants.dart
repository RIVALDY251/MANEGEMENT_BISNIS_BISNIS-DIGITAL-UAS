class AppConstants {
  // App Identity
  static const String appName = 'STRAVIX.ID';
  static const String appDisplayName = 'Stravix.ID';
  static const String appTagline = 'Smart Platform for Business Growth';
  static const String packageName = 'com.stravix.id';
  static const String appType = 'Digital Business Operating System (SaaS UMKM)';

  // Package Info
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;

  // API (for future backend integration)
  static const String baseUrl = 'https://api.stravix.id';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String keyToken = 'auth_token';
  static const String keyUserId = 'user_id';
  static const String keyUserData = 'user_data';
  static const String keyOnboardingSeen = 'onboarding_seen';
  static const String keyCurrentBusiness = 'current_business_id';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Date Formats
  static const String dateFormat = 'dd MMM yyyy';
  static const String dateTimeFormat = 'dd MMM yyyy HH:mm';
  static const String timeFormat = 'HH:mm';

  // Currency
  static const String currencySymbol = 'Rp';
  static const String currencyCode = 'IDR';
}
