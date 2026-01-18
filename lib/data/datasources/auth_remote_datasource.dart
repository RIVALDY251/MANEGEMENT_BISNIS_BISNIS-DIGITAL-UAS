import 'package:dio/dio.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String name, String email, String password);
  Future<void> sendEmailVerification(String email);
  Future<void> verifyEmail(String email, String code);
  Future<void> sendPasswordReset(String email);
  Future<void> resetPassword(String email, String code, String newPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      // Mock API call - replace with actual API endpoint
      await Future.delayed(const Duration(seconds: 1));
      
      // In real implementation:
      // final response = await dio.post(
      //   '${AppConstants.baseUrl}/auth/login',
      //   data: {'email': email, 'password': password},
      // );
      // return UserModel.fromJson(response.data);

      // Mock response
      return UserModel(
        id: 'user_12345',
        name: 'User Name',
        email: email,
        role: 'owner',
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<UserEntity> register(String name, String email, String password) async {
    try {
      // Mock API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock response
      return UserModel(
        id: 'user_12345',
        name: name,
        email: email,
        role: 'owner',
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<void> sendEmailVerification(String email) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> verifyEmail(String email, String code) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> resetPassword(String email, String code, String newPassword) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
  }
}
