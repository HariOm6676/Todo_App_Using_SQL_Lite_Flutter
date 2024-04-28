import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  primarySwatch: Colors.deepOrange,
  iconTheme: const IconThemeData(color: Colors.deepOrange),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  )),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.circular(5.0),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xff333739),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff333739),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  primarySwatch: Colors.deepOrange,
  iconTheme: const IconThemeData(color: Colors.deepOrange),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  )),
  cardTheme: CardTheme(
    color: Color.fromARGB(255, 100, 104, 105),
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.circular(5.0),
    ),
  ),
);
