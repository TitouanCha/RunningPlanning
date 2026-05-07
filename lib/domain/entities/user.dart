class User{
  final String id;
  final String token;
  final String name;
  final String role;

  User({
    required this.id,
    required this.token,
    required this.name,
    required this.role,
  });

  factory User.fromApi(Map<String, dynamic> json) {
    final token = json['access_token'] as String? ?? '';
    final userData = json['user'] as Map<String, dynamic>? ?? {};

    return User(
      id: userData['id'] as String? ?? '',
      token: token,
      name: userData['name'] as String? ?? '',
      role: userData['role'] as String? ?? '',
    );
  }
}