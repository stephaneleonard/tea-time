import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
  ),
  textTheme: const TextTheme(
    headline3: TextStyle(color: Colors.black),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
  ),
  textTheme: const TextTheme(
    headline3: TextStyle(color: Colors.white),
  ),
);
