import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housematic_radio/const/app_colors.dart';

class AppTheme {
  ThemeData lightTheme(context) => ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.green,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.black, size: 20),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 18),
        ),
        colorScheme: const ColorScheme.light(),
        // primarySwatch: Colors.blue,
        textTheme: GoogleFonts.darkerGrotesqueTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
              ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      );

  ThemeData darkTheme(context) => ThemeData(
        tabBarTheme: const TabBarTheme(
          labelStyle: TextStyle(fontSize: 18),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.green,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white, size: 20),
        ),
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(),
        //  primarySwatch: Colors.amber,
        textTheme: GoogleFonts.darkerGrotesqueTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
              ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      );
}
