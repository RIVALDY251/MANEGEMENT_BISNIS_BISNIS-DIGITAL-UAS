import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String name, String email, String password);
  Future<void> logout();
  Future<void> sendEmailVerification(String email);
  Future<void> verifyEmail(String email, String code);
  Future<void> sendPasswordReset(String email);
  Future<void> resetPassword(String email, String code, String newPassword);
  Future<UserEntity?> getCurrentUser();
}
