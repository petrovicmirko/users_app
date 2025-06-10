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
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.username),
              );
            },
          );
        },
      ),
      floatingActionButton: Consumer<UserViewModel>(
        builder: (context, userViewModel, child) {
          return CustomButton(
            text: 'Refresh users',
            onPressed: userViewModel.fetchUsers,
          );
        },
      ),
    );
  }
}
