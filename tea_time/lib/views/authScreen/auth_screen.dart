import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tea_time/utils/auth.dart';
import 'package:tea_time/views/mainScreen.dart/main_screen.dart';
import 'package:tea_time/widgets/appbard.dart';

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

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tea Time'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: const LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return 'Please enter valid email';
    }
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    // if (!RegExp(
    //         r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,50}$')
    //     .hasMatch(value)) {
    //   return '''A password must bem inimum eight characters,
    //   at least one uppercase letter, one lowercase letter,
    //   one number and one special character:''';
    // }
    return null;
  }

  String errorMessage = '';
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40),
          CustomInputField(
            controller: _email,
            hint: 'Type in your email',
            validator: emailValidator,
          ),
          CustomInputField(
            controller: _password,
            hint: 'Type in your password',
            obscureText: true,
            validator: passwordValidator,
          ),
          Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                  double.infinity,
                  50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                if (_formKey.currentState!.validate()) {
                  try {
                    await firebaseAuth.signInWithEmailAndPassword(
                        email: _email.text, password: _password.text);
                    Navigator.popAndPushNamed(context, '/main');
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      errorMessage = e.message ?? 'Unexpected error';
                      isLoading = false;
                    });
                  }
                }
              },
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('login'),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 10),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       minimumSize: const Size(
          //         double.infinity,
          //         50,
          //       ),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //     onPressed: () async {
          //       setState(() {
          //         isLoading = true;
          //       });
          //       if (_formKey.currentState!.validate()) {
          //         try {
          //           await firebaseAuth.createUserWithEmailAndPassword(
          //               email: _email.text, password: _password.text);
          //           Navigator.popAndPushNamed(context, '/main');
          //         } on FirebaseAuthException catch (e) {
          //           setState(() {
          //             errorMessage = e.message ?? 'Unexpected error';
          //             isLoading = false;
          //           });
          //         }
          //       }
          //     },
          //     child: isLoading
          //         ? const CircularProgressIndicator(
          //             color: Colors.white,
          //           )
          //         : const Text('Sign up'),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {required this.controller,
      required this.hint,
      required this.validator,
      this.obscureText = false,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: hint,
              fillColor: Colors.white70),
          controller: controller,
          obscureText: obscureText,
          keyboardType: TextInputType.emailAddress,
          validator: validator,
        ));
  }
}
