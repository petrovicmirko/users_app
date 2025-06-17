class UserApiModel {
  final int? id;
  final String name;
  final String username;
  final String email;

  UserApiModel({
    this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return UserApiModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {'name': name, 'username': username, 'email': email};

    if (id != null) {
      map['id'] = id.toString();
    }

    return map;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'username': username, 'email': email};
  }
}
