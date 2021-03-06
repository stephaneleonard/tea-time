import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/core/theming/auth/auth.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/widgets/custom_input_field.dart';

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
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value)) {
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
            inputType: TextInputType.emailAddress,
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                if (_formKey.currentState!.validate()) {
                  try {
                    await firebaseAuth.signInWithEmailAndPassword(
                      email: _email.text,
                      password: _password.text,
                    );
                    if (!mounted) return;
                    context.read<UserCubit>().getUserInfos();
                    Navigator.popAndPushNamed(context, '/main');
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      errorMessage = e.message ?? 'Unexpected error';
                    });
                  }
                }
                setState(() {
                  isLoading = false;
                });
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

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: const Text('Sign in'),
            ),
          ),
        ],
      ),
    );
  }
}
