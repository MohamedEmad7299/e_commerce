
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() {
  return ThemeData(
    indicatorColor: Colors.deepPurple,
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.deepPurple,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: Colors.deepPurple,
    ),
    iconTheme: IconThemeData(
        color: Colors.deepPurple
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.deepPurple,
      labelStyle: TextStyle(
          color: Colors.black
      ),
      focusedBorder: OutlineInputBorder(
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        iconTheme: IconThemeData(color: Colors.black, size: 30)),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
    ),
  );
}