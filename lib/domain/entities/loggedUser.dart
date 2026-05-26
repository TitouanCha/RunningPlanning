class LoggedUser{
  final String id;
  final String token;
  final String name;
  final String role;

  LoggedUser({
    required this.id,
    required this.token,
    required this.name,
    required this.role,
  });

  factory LoggedUser.fromApi(Map<String, dynamic> json) {
    final token = json['access_token'] as String? ?? '';
    final userData = json['user'] as Map<String, dynamic>? ?? {};

    return LoggedUser(
      id: userData['id'] as String? ?? '',
      token: token,
      name: userData['name'] as String? ?? '',
      role: userData['role'] as String? ?? '',
    );
  }
}