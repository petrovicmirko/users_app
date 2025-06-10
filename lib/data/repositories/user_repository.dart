import 'package:uuid/uuid.dart';

import 'package:users_app/data/services/user_service.dart';
import 'package:users_app/domain/models/user.dart';
import 'package:users_app/data/model/user_api_model.dart';

class UserRepository {
  late UserService _userService;

  UserRepository() {
    _userService = UserService();
  }

  Future<List<User>> fetchUsers() async {
    final apiUsers = await _userService.fetchUsers();
    return apiUsers
        .map((apiUser) => User(apiUser.id, apiUser.name, apiUser.username))
        .toList();
  }

  Future<User> addUser(String name, String username, String email) async {
    final apiUser = UserApiModel(
      id: const Uuid().v4(),
      name: name,
      username: username,
      email: email,
    );

    final addedApiUser = await _userService.addUser(apiUser);
    return User(addedApiUser.id, addedApiUser.name, addedApiUser.username);
  }
}
