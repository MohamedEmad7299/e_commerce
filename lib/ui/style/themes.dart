import 'package:e_commerce/ui/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() {
  return ThemeData(
    indicatorColor: cabaret,
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: cabaret,
        linearTrackColor: cabaret75
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: cabaret75,
      selectionHandleColor: cabaret,
    ),
    iconTheme: IconThemeData(
        color: cabaret
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: cabaret,
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


ThemeData darkTheme() {
  return ThemeData(
      iconTheme: IconThemeData(
          color: Colors.white
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: Colors.white,
        suffixIconColor: Colors.white,
        labelStyle: TextStyle(
            color: Colors.white
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2.0,
              color: Colors.white
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.black,
      appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0,
          shadowColor: Colors.black,
          surfaceTintColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light),
          iconTheme: IconThemeData(color: Colors.white, size: 30)),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
      )
  );
}