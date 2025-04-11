import 'package:flutter/material.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/util/provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = MSProvider.get<AuthenticationState>(context);
    return Center(
        child: ElevatedButton(
      onPressed: () {
        authState.logout();
      },
      child: const Text('Logout'),
    ));
  }
}
