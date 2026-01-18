import '../../repositories/auth_repository.dart';

class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<void> execute(String email, String code) {
    return repository.verifyEmail(email, code);
  }
}
