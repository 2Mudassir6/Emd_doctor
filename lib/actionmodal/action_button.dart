import 'package:flutter/material.dart';

class _ActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ActionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Action',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
