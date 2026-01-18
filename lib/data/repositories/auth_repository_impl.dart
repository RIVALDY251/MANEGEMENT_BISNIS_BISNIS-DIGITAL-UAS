import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await remoteDataSource.login(email, password);
    await localDataSource.saveToken('token_${user.id}');
    await localDataSource.saveUserId(user.id);
    return user;
  }

  @override
  Future<UserEntity> register(String name, String email, String password) async {
    final user = await remoteDataSource.register(name, email, password);
    await localDataSource.saveToken('token_${user.id}');
    await localDataSource.saveUserId(user.id);
    return user;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearAuth();
  }

  @override
  Future<void> sendEmailVerification(String email) async {
    await remoteDataSource.sendEmailVerification(email);
  }

  @override
  Future<void> verifyEmail(String email, String code) async {
    await remoteDataSource.verifyEmail(email, code);
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    await remoteDataSource.sendPasswordReset(email);
  }

  @override
  Future<void> resetPassword(String email, String code, String newPassword) async {
    await remoteDataSource.resetPassword(email, code, newPassword);
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userId = await localDataSource.getUserId();
    if (userId == null) return null;
    // In real implementation, fetch user from API
    return null;
  }
}
