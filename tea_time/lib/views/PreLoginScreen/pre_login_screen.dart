import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/core/theming/auth/auth.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/views/LoginScreen/login_screen.dart';
import 'package:tea_time/views/MainScreen/main_screen.dart';

class PreLoginScreen extends StatelessWidget {
  const PreLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = firebaseAuth.currentUser;
    if (user != null) {
      context.read<UserCubit>().getUserInfos();
      return const MainScreen();
    }
    return const LoginScreen();
  }
}
