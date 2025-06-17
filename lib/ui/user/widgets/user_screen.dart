import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:users_app/ui/core/themes/theme_provider.dart';
import 'package:users_app/ui/core/ui/custom_floating_action_button.dart';

import 'package:users_app/ui/user/view_model/user_view_model.dart';
import 'package:users_app/ui/user/widgets/add_user_dialog.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) => themeProvider.toggleTheme(value),
              );
            },
          ),
        ],
      ),
      body: Consumer<UserViewModel>(
        builder: (context, userViewModel, child) {
          return ListView.builder(
            itemCount: userViewModel.users.length,
            itemBuilder: (context, index) {
              final user = userViewModel.users[index];
              return Dismissible(
                key: Key(user.id.toString()),
                background: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    color: Colors.blue,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16.0),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
                secondaryBackground: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                direction: DismissDirection.horizontal,
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    userViewModel.setSelectedUser(user);
                    await showDialog(
                      context: context,
                      builder: (context) => const AddUserDialog(),
                    );
                    return false;
                  } else {
                    return await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirm Deletion'),
                          content: Text(
                            'Are you sure you want to delete ${user.name}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                onDismissed: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    userViewModel
                        .deleteUser(user.id)
                        .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'User ${user.name} deleted successfully',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        })
                        .catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to delete user: $e'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          userViewModel.fetchUsers();
                        });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.username),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddUserDialog(),
          );
        },
        icon: Icons.add,
      ),
    );
  }
}
