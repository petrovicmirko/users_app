import 'package:flutter/material.dart';

import 'package:users_app/data/repositories/user_repository.dart';
import 'package:users_app/domain/models/user.dart';

class UserViewModel extends ChangeNotifier {
  late UserRepository _userRepository;
  List<User> users = [];

  User? _selectedUser;

  User? get selectedUser => _selectedUser;
  bool get isEditing => _selectedUser != null;

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

  Future<void> updateUser(
    int id,
    String name,
    String username,
    String email,
  ) async {
    try {
      final updatedUser = await _userRepository.updateUser(
        id,
        name,
        username,
        email,
      );

      users = users.map((user) => user.id == id ? updatedUser : user).toList();
      _selectedUser = null;
    } catch (e) {
      print('Failed to update user: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _userRepository.deleteUser(id);
      users = users.where((user) => user.id != id).toList();
    } catch (e) {
      print('Failed to delete user: $e');
    } finally {
      notifyListeners();
    }
  }

  void setSelectedUser(User? user) {
    _selectedUser = user;
    notifyListeners();
  }
}
