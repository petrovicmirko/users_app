import 'package:flutter/material.dart';

import 'package:users_app/data/repositories/user_repository.dart';
import 'package:users_app/domain/models/user.dart';

class UserViewModel extends ChangeNotifier {
  late UserRepository _userRepository;
  List<User> users = [];

  UserViewModel() {
    _userRepository = UserRepository();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    users = await _userRepository.fetchUsers();
    print('Fetched users: $users');
    notifyListeners();
  }

  Future<void> addUser(String name, String username, String email) async {
    try {
      final newUser = await _userRepository.addUser(name, username, email);
      users = [...users, newUser];
    } catch (e) {
      print('Failed to add user: $e');
    } finally {
      notifyListeners();
    }
  }
}
