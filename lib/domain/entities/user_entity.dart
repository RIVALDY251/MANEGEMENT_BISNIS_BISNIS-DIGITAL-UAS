class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final String role;
  final bool isEmailVerified;
  final DateTime createdAt;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    required this.role,
    this.isEmailVerified = false,
    required this.createdAt,
  });
}
