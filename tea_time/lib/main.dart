import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/core/theming/theming.dart';
import 'package:tea_time/cubit/collection_cubit.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/data/repository/collection_repository_impl.dart';
import 'package:tea_time/data/repository/user_repositiory_impl.dart';
import 'package:tea_time/views/BrewingScreen/brewing_screen.dart';
import 'package:tea_time/views/CollectionCreation/collection_creation.dart';
import 'package:tea_time/views/CreateTea/create_tea_screen.dart';
import 'package:tea_time/views/MainScreen/main_screen.dart';
import 'package:tea_time/views/PreLoginScreen/pre_login_screen.dart';
import 'package:tea_time/views/SignInScreen/sign_in_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(UserRepositoryImpl()),
        ),
        BlocProvider<CollectionCubit>(
          create: (BuildContext context) =>
              CollectionCubit(CollectionRepositoryImpl()),
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
          '/signin': (BuildContext context) => const SignInScreen(),
          '/main': (BuildContext context) => const MainScreen(),
          '/brewing': (BuildContext context) => const BrewingScreen(),
          '/collection_creation': (BuildContext context) =>
              const CollectionCreationScreen(),
          '/create_tea': (BuildContext context) => const CreateTeaScreen(),
        },
      ),
    );
  }
}
