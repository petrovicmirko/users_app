import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:users_app/ui/core/ui/custom_button.dart';
import 'package:users_app/ui/user/view_model/user_view_model.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();

    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    return AlertDialog(
      title: const Text('Add new user'),
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
          onPressed: () => {Navigator.pop(context)},
          child: const Text('Cancel'),
        ),
        CustomButton(
          text: 'Add',
          onPressed: () {
            final name = nameController.text.trim();
            final username = usernameController.text.trim();
            final email = emailController.text.trim();
            if (name.isNotEmpty && username.isNotEmpty && email.isNotEmpty) {
              userViewModel.addUser(name, username, email).then((_) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User added succesfully'),
                    duration: Duration(seconds: 1),
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
