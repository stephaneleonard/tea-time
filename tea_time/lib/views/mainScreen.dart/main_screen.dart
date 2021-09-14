import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/utils/auth.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().getUserInfos();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          BlocBuilder<UserCubit, UserState>(
              builder: (BuildContext context, UserState state) {
            if (state is UserLoaded) {
              return Text(state.user.name);
            }
            return const Text('error');
          }),
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
