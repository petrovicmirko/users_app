import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:users_app/ui/core/ui/custom_button.dart';
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
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddUserDialog(),
              );
            },
            icon: Icon(Icons.add),
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
                key: Key(user.id),
                background: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 16.0),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.horizontal,
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    userViewModel.setSelectedUser(user);
                    await showDialog(
                      context: context,
                      builder: (context) => const AddUserDialog(),
                    );
                    return false; // Prevent dismissal after editing
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
                              content: Text('Korisnik ${user.name} obrisan'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        })
                        .catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Greška pri brisanju korisnika: $e',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          userViewModel.fetchUsers();
                        });
                  }
                },
                child: ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.username),
                ),
              );
              // return ListTile(
              //   title: Text(user.name),
              //   subtitle: Text(user.username),
              //   trailing: IconButton(
              //     icon: Icon(Icons.delete, color: Colors.red),
              //     onPressed: () {
              //       userViewModel.deleteUser(user.id).then((_) {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text(
              //               'User ${user.name} deleted successfully',
              //             ),
              //             duration: Duration(seconds: 1),
              //           ),
              //         );
              //       });
              //     },
              //   ),
              // );
            },
          );
        },
      ),
      floatingActionButton: CustomButton(
        text: 'Refresh users',
        onPressed: context.read<UserViewModel>().fetchUsers,
      ),
    );
  }
}
