import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:users_app/ui/core/ui/custom_button.dart';
import 'package:users_app/ui/user/view_model/user_view_model.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    final isEditing = userViewModel.isEditing;
    final selectedUser = userViewModel.selectedUser;

    final nameController = TextEditingController(
      text: isEditing ? selectedUser?.name : '',
    );
    final usernameController = TextEditingController(
      text: isEditing ? selectedUser?.username : '',
    );
    final emailController = TextEditingController(
      text: isEditing ? selectedUser?.email : '',
    );

    return AlertDialog(
      title: Text(isEditing ? 'Update user' : 'Add new user'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed:
              () => {
                userViewModel.setSelectedUser(null),
                Navigator.pop(context),
              },
          child: const Text('Cancel'),
        ),
        CustomButton(
          text: 'Save',
          onPressed: () {
            final name = nameController.text.trim();
            final username = usernameController.text.trim();
            final email = emailController.text.trim();
            if (name.isNotEmpty && username.isNotEmpty && email.isNotEmpty) {
              final future =
                  isEditing
                      ? userViewModel.updateUser(
                        selectedUser!.id,
                        name,
                        username,
                        email,
                      )
                      : userViewModel.addUser(name, username, email);
              future.then((_) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isEditing
                          ? 'User updated successfully'
                          : 'User added successfully',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              });
            }
          },
        ),
      ],
    );
  }
}
