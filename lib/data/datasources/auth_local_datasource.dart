import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> saveUserId(String userId);
  Future<String?> getUserId();
  Future<void> clearAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(AppConstants.keyToken, token);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(AppConstants.keyToken);
  }

  @override
  Future<void> saveUserId(String userId) async {
    await sharedPreferences.setString(AppConstants.keyUserId, userId);
  }

  @override
  Future<String?> getUserId() async {
    return sharedPreferences.getString(AppConstants.keyUserId);
  }

  @override
  Future<void> clearAuth() async {
    await sharedPreferences.remove(AppConstants.keyToken);
    await sharedPreferences.remove(AppConstants.keyUserId);
    await sharedPreferences.remove(AppConstants.keyUserData);
  }
}
