import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/utils/theme.dart';
import 'package:tea_time/views/authScreen/auth_screen.dart';
import 'package:tea_time/views/mainScreen.dart/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // ignore: always_specify_types
      providers: [
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        home: const PreLoginScreen(),
        routes: <String, Widget Function(BuildContext)>{
          // When navigating to the "/" route, build the FirstScreen widget.
          '/login': (BuildContext context) => const PreLoginScreen(),
          '/main': (BuildContext context) => const MainScreen(),
        },
      ),
    );
  }
}
