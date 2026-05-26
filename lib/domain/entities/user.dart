class User {
  final String id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromApi(Map<String, dynamic> json){
    return User(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? ''
    );
  }
}