class UserApiModel {
  final String id;
  final String name;
  final String username;
  final String email;

  UserApiModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return UserApiModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'username': username, 'email': email};
  }
}
