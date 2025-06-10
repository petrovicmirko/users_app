import 'package:flutter/material.dart';
import 'package:users_app/ui/core/themes/app_theme.dart';
import 'package:users_app/ui/user/widgets/user_screen.dart';
import 'package:provider/provider.dart';
import 'package:users_app/ui/user/view_model/user_view_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
      create: (context) => UserViewModel(),
      child: MaterialApp(
        title: 'Users App',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: UserScreen(),
      ),
    );
  }
}
