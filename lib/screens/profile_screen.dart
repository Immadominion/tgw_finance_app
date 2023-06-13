import 'package:flutter/material.dart';
import 'package:flutter/material.dart ';

import '../wdgets/widgets_method.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, 'Profile'),
      body: Column(
        children: [
          buildProfileImageAvatar(),
          const SizedBox(height: 30.0),
          buildMenuItem(Icons.person_outline, 'My Account', () {}),
          const SizedBox(height: 15.0),
          buildMenuItem(
              Icons.notifications_active_outlined, 'Notification', () {}),
          const SizedBox(height: 15.0),
          buildMenuItem(Icons.settings_outlined, 'Setting', () {}),
          const SizedBox(height: 15.0),
          buildMenuItem(Icons.help_outline, 'Help Center', () {}),
          const SizedBox(height: 15.0),
          buildMenuItem(Icons.logout, 'Logout', () {}),
        ],
      ),
    );
  }
}
