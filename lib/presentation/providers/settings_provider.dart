import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class SettingsState {
  final bool notificationsEnabled;
  final String language;

  SettingsState({
    this.notificationsEnabled = true,
    this.language = 'id',
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    String? language,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      final language = prefs.getString(AppConstants.keyLanguage) ?? 'id';
      
      state = SettingsState(
        notificationsEnabled: notificationsEnabled,
        language: language,
      );
    } catch (e) {
      // Use defaults
    }
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notifications_enabled', enabled);
      state = state.copyWith(notificationsEnabled: enabled);
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> setLanguage(String language) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyLanguage, language);
      state = state.copyWith(language: language);
    } catch (e) {
      // Handle error silently
    }
  }

  String getLanguageLabel(String code) {
    switch (code) {
      case 'id':
        return 'Indonesia';
      case 'en':
        return 'English';
      default:
        return 'Indonesia';
    }
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
