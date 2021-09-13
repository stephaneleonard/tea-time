import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tea_time/utils/auth.dart';
import 'package:tea_time/views/mainScreen.dart/main_screen.dart';

class PreLoginScreen extends StatelessWidget {
  const PreLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      return const MainScreen();
    }
    return const LoginScreen();
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _password,
                obscureText: true,
              ),
              TextButton(
                onPressed: () {
                  firebaseAuth.signInWithEmailAndPassword(
                      email: _email.text, password: _password.text);
                  Navigator.popAndPushNamed(context, '/main');
                },
                child: const Text('login'),
              ),
              TextButton(
                onPressed: () {
                  firebaseAuth.createUserWithEmailAndPassword(
                      email: _email.text, password: _password.text);
                  Navigator.popAndPushNamed(context, '/main');
                },
                child: const Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
