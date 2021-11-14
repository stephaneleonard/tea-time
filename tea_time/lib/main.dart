import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/core/theming/theming.dart';
import 'package:tea_time/cubit/collection_cubit.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/data/repository/collection_repository.dart';
import 'package:tea_time/data/repository/user_repositiory.dart';
import 'package:tea_time/views/BrewingScreen/brewing_screen.dart';
import 'package:tea_time/views/MainScreen/main_screen.dart';
import 'package:tea_time/views/PreLoginScreen/pre_login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(IUserRepository()),
        ),
        BlocProvider<CollectionCubit>(
          create: (BuildContext context) =>
              CollectionCubit(ICollectionRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tea Time',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const PreLoginScreen(),
        routes: <String, Widget Function(BuildContext)>{
          // When navigating to the "/" route, build the FirstScreen widget.
          '/login': (BuildContext context) => const PreLoginScreen(),
          '/main': (BuildContext context) => const MainScreen(),
          '/brewing': (BuildContext context) => const BrewingScreen(),
        },
      ),
    );
  }
}
