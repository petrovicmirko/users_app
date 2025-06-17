import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:users_app/data/model/user_api_model.dart';

class UserService {
  final String _baseUrl = 'http://10.99.159.199:8080/api/users';
  // Database? _database;

  UserService();

  Future<List<UserApiModel>> fetchUsers1() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => UserApiModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetchUsers(): $e');
    }
  }

  Future<UserApiModel> addUser1(UserApiModel userApiModel) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userApiModel.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return UserApiModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('failed to add user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to addUser(): $e');
    }
  }

  Future<UserApiModel> updateUser1(UserApiModel userApiModel) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${userApiModel.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userApiModel.toMap()),
      );

      if (response.statusCode == 200) {
        return UserApiModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to updateUser(): $e');
    }
  }

  Future<void> deleteUser1(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('Failed to delete user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to deleteUser(): $e');
    }
  }

  // Future<Database> get database async {
  //   if (_database != null) return _database!;
  //   _database = await _initDatabase();
  //   return _database!;
  // }

  // Future<Database> _initDatabase() async {
  //   final dbPath = await getDatabasesPath();
  //   final path = join(dbPath, 'users_app.db');
  //   return await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: (db, version) async {
  //       await db.execute(
  //         '''CREATE TABLE users (id TEXT PRIMARY KEY, name TEXT NOT NULL, username TEXT NOT NULL, email TEXT NOT NULL)''',
  //       );
  //       await db.insert('users', {
  //         'id': '1',
  //         'name': 'Bojan Jazic',
  //         'username': 'bojan99',
  //         'email': 'bojan@gmail.com',
  //       });
  //     },
  //   );
  // }

  // Future<List<UserApiModel>> fetchUsers() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('users');
  //   return maps
  //       .map(
  //         (map) => UserApiModel(
  //           id: map['id'] as int,
  //           name: map['name'] as String,
  //           username: map['username'] as String,
  //           email: map['email'] as String,
  //         ),
  //       )
  //       .toList();
  // }

  // Future<UserApiModel> addUser(UserApiModel userApiModel) async {
  //   final db = await database;
  //   final newUser = UserApiModel(
  //     id: userApiModel.id,
  //     name: userApiModel.name,
  //     username: userApiModel.username,
  //     email: userApiModel.email,
  //   );
  //   await db.insert(
  //     'users',
  //     newUser.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //   return newUser;
  // }

  // Future<UserApiModel> updateUser(UserApiModel userApiModel) async {
  //   try {
  //     final db = await database;
  //     final rowsAffected = await db.update(
  //       'users',
  //       userApiModel.toMap(),
  //       where: 'id = ?',
  //       whereArgs: [userApiModel.id],
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //     print(
  //       'Updated user with id: ${userApiModel.id}, rows affected: $rowsAffected',
  //     );
  //     if (rowsAffected == 0) {
  //       throw Exception('No user found with id: ${userApiModel.id}');
  //     }
  //     return userApiModel;
  //   } catch (e) {
  //     print('Error updating user: $e');
  //     throw Exception('Failed to update user: $e');
  //   }
  // }

  // Future<void> deleteUser(String id) async {
  //   try {
  //     final db = await database;
  //     final rowsAffected = await db.delete(
  //       'users',
  //       where: 'id = ?',
  //       whereArgs: [id],
  //     );
  //     print('Deleted user with id $id, rows affected: $rowsAffected');
  //   } catch (e) {
  //     print('Error deleting user: $e');
  //     throw Exception('Failed to delete user: $e');
  //   }
  // }
}
