import 'package:flutter/material.dart';
import 'package:tea_time/utils/auth.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Text(firebaseAuth.currentUser!.email ?? ''),
          TextButton(
            onPressed: () {
              firebaseAuth.signOut();
              Navigator.popAndPushNamed(context, '/login');
            },
            child: const Text('sign out'),
          ),
        ],
      )),
    );
  }
}
