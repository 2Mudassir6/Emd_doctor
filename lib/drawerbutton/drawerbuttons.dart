import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final Logger _logger = Logger(); // Define _logger here

class DrawerButtons extends StatelessWidget {
  const DrawerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DrawerButton(
          icon: Icons.dashboard,
          text: 'Dashboard',
          route: 'dashboard',
        ),
        SizedBox(
          height: 10,
        ),
        DrawerButton(
          icon: Icons.credit_card,
          text: 'Add New License',
          route: '/license',
        ),
        SizedBox(
          height: 10,
        ),
        DrawerButton(
          icon: Icons.lock,
          text: 'Change Password',
          route: '/updatepassword',
        ),
        SizedBox(
          height: 10,
        ),
        DrawerButton(
          icon: Icons.person,
          text: 'User Settings',
          route: '/user_settings',
        ),
        SizedBox(
          height: 10,
        ),
        DrawerButton(
          icon: Icons.exit_to_app,
          text: 'Sign Out',
          route: '/sign_out',
        ),
      ],
    );
  }
}


class DrawerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final String route;

  const DrawerButton({super.key,
    required this.icon,
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _logger.d('Navigating to $route'); // Using _logger here
        Navigator.pushReplacementNamed(context, route);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 16.0),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
