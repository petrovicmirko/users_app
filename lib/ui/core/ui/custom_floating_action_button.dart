import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  // final String text;
  final VoidCallback onPressed;
  final IconData icon;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onPressed, child: Icon(icon));
  }
}
