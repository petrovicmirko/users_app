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
    final apiUsers = await _userService.fetchUsers1();
    return apiUsers
        .map(
          (apiUser) =>
              User(apiUser.id!, apiUser.name, apiUser.username, apiUser.email),
        )
        .toList();
  }

  Future<User> addUser(String name, String username, String email) async {
    final apiUser = UserApiModel(name: name, username: username, email: email);

    final addedApiUser = await _userService.addUser1(apiUser);
    return User(
      addedApiUser.id!,
      addedApiUser.name,
      addedApiUser.username,
      addedApiUser.email,
    );
  }

  Future<User> updateUser(
    int id,
    String name,
    String username,
    String email,
  ) async {
    final apiUser = UserApiModel(
      id: id,
      name: name,
      username: username,
      email: email,
    );

    final updatedApiUser = await _userService.updateUser1(apiUser);
    return User(
      updatedApiUser.id!,
      updatedApiUser.name,
      updatedApiUser.username,
      updatedApiUser.email,
    );
  }

  Future<void> deleteUser(int id) async {
    await _userService.deleteUser1(id);
  }
}
