import 'package:flutter/material.dart';
import 'package:tea_time/views/SignInScreen/sign_in_form.dart';
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
