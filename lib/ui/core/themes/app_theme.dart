import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.teal,
      secondary: Colors.tealAccent,
      surface: Colors.white,
      background: Color(0xFFF5F5F5),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
    ),
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
      textColor: Colors.black87,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.teal),
      trackColor: MaterialStateProperty.all(Colors.teal.shade200),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.teal.shade200,
      secondary: Colors.tealAccent,
      surface: Color(0xFF1E1E1E),
      background: Color(0xFF121212),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.teal.shade900,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.teal.shade600,
      foregroundColor: Colors.white,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: Colors.teal.shade800,
      textColor: Colors.white,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.tealAccent),
      trackColor: MaterialStateProperty.all(Colors.teal.shade600),
    ),
  );
}
