import 'package:flutter/material.dart';
import 'package:tea_time/utils/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          await firebaseAuth.signOut();
          Navigator.popAndPushNamed(context, '/login');
        },
        child: const Text('sign out'),
      ),
    );
  }
}
