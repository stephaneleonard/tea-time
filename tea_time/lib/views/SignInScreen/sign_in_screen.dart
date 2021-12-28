import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tea_time/core/theming/auth/auth.dart';
import 'package:tea_time/data/repository/user_repositiory_impl.dart';
import 'package:tea_time/views/LoginScreen/login_screen.dart';
import 'package:tea_time/views/SignInScreen/sign_in_button.dart';
import 'package:tea_time/widgets/custom_app_bar.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tea Time'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: const SignInForm(),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordVerificationController =
      TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

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

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if (value.length < 8) {
      return 'Password needs to be at least 8 character';
    }
    if (value != _passwordVerificationController.text) {
      return 'Not the same';
    }

    return null;
  }

  String? passwordVerificationValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if (value.length < 8) {
      return 'Password needs to be at least 8 character';
    }
    if (value != _passwordController.text) {
      return 'Not the same';
    }

    return null;
  }

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        // create account
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        final String id = firebaseAuth.currentUser!.uid;
        await UserRepositoryImpl().createUser(id, _nameController.text);

        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/main',
          (Route<dynamic> route) => false,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          setState(() {
            errorMessage = 'The account already exists for that email.';
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = e.toString();
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          CustomInputField(
            controller: _emailController,
            hint: 'Email',
            validator: emailValidator,
          ),
          CustomInputField(
            controller: _nameController,
            hint: 'Name',
            validator: nameValidator,
          ),
          CustomInputField(
            controller: _passwordController,
            hint: 'Password',
            validator: passwordValidator,
            obscureText: true,
          ),
          CustomInputField(
            controller: _passwordVerificationController,
            hint: 'Confirm password',
            validator: passwordVerificationValidator,
            obscureText: true,
          ),
          Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          SignInButton(isLoading: isLoading, func: signIn),
        ],
      ),
    );
  }
}
