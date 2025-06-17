import 'package:flutter/material.dart';
import 'package:users_app/ui/core/themes/app_theme.dart';
import 'package:users_app/ui/core/themes/theme_provider.dart';
import 'package:users_app/ui/user/widgets/user_screen.dart';
import 'package:provider/provider.dart';
import 'package:users_app/ui/user/view_model/user_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserViewModel>(create: (_) => UserViewModel()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Users App',
      themeMode: themeProvider.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: UserScreen(),
    );
  }
}
