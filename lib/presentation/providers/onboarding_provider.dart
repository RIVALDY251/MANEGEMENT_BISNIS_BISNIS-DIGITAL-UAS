import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

final onboardingSeenProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(AppConstants.keyOnboardingSeen) ?? false;
});

final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, void>((ref) {
  return OnboardingNotifier();
});

class OnboardingNotifier extends StateNotifier<void> {
  OnboardingNotifier() : super(null);

  Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyOnboardingSeen, true);
  }
}
