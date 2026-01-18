import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class AuthState {
  final bool isAuthenticated;
  final String? token;
  final String? userId;
  final Map<String, dynamic>? userData;

  AuthState({
    this.isAuthenticated = false,
    this.token,
    this.userId,
    this.userData,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    String? userId,
    Map<String, dynamic>? userData,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      userId: userId ?? this.userId,
      userData: userData ?? this.userData,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.keyToken);
    final userId = prefs.getString(AppConstants.keyUserId);

    if (token != null && userId != null) {
      state = state.copyWith(
        isAuthenticated: true,
        token: token,
        userId: userId,
      );
    }
  }

  Future<void> login(String email, String password) async {
    // Mock login - replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    
    final prefs = await SharedPreferences.getInstance();
    const mockToken = 'mock_token_12345';
    const mockUserId = 'user_12345';
    
    await prefs.setString(AppConstants.keyToken, mockToken);
    await prefs.setString(AppConstants.keyUserId, mockUserId);
    
    state = state.copyWith(
      isAuthenticated: true,
      token: mockToken,
      userId: mockUserId,
    );
  }

  Future<void> register(String name, String email, String password) async {
    // Mock register - replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    
    final prefs = await SharedPreferences.getInstance();
    const mockToken = 'mock_token_12345';
    const mockUserId = 'user_12345';
    
    await prefs.setString(AppConstants.keyToken, mockToken);
    await prefs.setString(AppConstants.keyUserId, mockUserId);
    
    state = state.copyWith(
      isAuthenticated: true,
      token: mockToken,
      userId: mockUserId,
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyToken);
    await prefs.remove(AppConstants.keyUserId);
    await prefs.remove(AppConstants.keyUserData);
    
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
