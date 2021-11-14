import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// light theme of the app
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle:
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.w400,
    ),
  ),
  textTheme: const TextTheme(
    headline3: TextStyle(color: Colors.black),
  ),
);

/// dark theme of the app
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.w400,
    ),
  ),
  textTheme: const TextTheme(
    headline3: TextStyle(color: Colors.white),
  ),
);
