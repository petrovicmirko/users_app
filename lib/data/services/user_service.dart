import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:users_app/data/model/user_api_model.dart';

class UserService {
  Database? _database;

  UserService();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'users_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE users (id TEXT PRIMARY KEY, name TEXT NOT NULL, username TEXT NOT NULL, email TEXT NOT NULL)''',
        );
        await db.insert('users', {
          'id': '1',
          'name': 'Bojan Jazic',
          'username': 'bojan99',
          'email': 'bojan@gmail.com',
        });
      },
    );
  }

  Future<List<UserApiModel>> fetchUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return maps
        .map(
          (map) => UserApiModel(
            id: map['id'] as String,
            name: map['name'] as String,
            username: map['username'] as String,
            email: map['email'] as String,
          ),
        )
        .toList();
  }

  Future<UserApiModel> addUser(UserApiModel userApiModel) async {
    final db = await database;
    final newUser = UserApiModel(
      id: userApiModel.id,
      name: userApiModel.name,
      username: userApiModel.username,
      email: userApiModel.email,
    );
    await db.insert(
      'users',
      newUser.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return newUser;
  }

  Future<UserApiModel> updateUser(UserApiModel userApiModel) async {
    try {
      final db = await database;
      final rowsAffected = await db.update(
        'users',
        userApiModel.toMap(),
        where: 'id = ?',
        whereArgs: [userApiModel.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print(
        'Updated user with id: ${userApiModel.id}, rows affected: $rowsAffected',
      );
      if (rowsAffected == 0) {
        throw Exception('No user found with id: ${userApiModel.id}');
      }
      return userApiModel;
    } catch (e) {
      print('Error updating user: $e');
      throw Exception('Failed to update user: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      final db = await database;
      final rowsAffected = await db.delete(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Deleted user with id $id, rows affected: $rowsAffected');
    } catch (e) {
      print('Error deleting user: $e');
      throw Exception('Failed to delete user: $e');
    }
  }

  // Future<List<UserApiModel>> fetchUsers() async {
  //   try {
  //     final response = await http.get(Uri.parse(_baseUrl));
  //     print(response.statusCode);

  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonResponse = json.decode(response.body);
  //       return jsonResponse.map((json) => UserApiModel.fromJson(json)).toList();
  //     } else {
  //       throw Exception('Failed to load users: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load users: $e');
  //   }
  // }
}
