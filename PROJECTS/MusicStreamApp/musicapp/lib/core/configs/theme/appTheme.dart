import 'package:flutter/material.dart';
import 'package:musicapp/core/configs/theme/appColor.dart';

class AppTheme {
  static final lightTheme =ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: 'Satoshi',
    textTheme: ThemeData.light().textTheme.copyWith(
      bodyLarge: TextStyle(color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.all(30),
      hintStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.grey,
      ),
      border:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.black,
          width: 0.4,
        )
      ),
      enabledBorder : OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.black,
          width: 0.4,
        )
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        )
      )
    )
  );

  static final darkTheme =ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground ,
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    textTheme: ThemeData.dark().textTheme.copyWith(
      bodyLarge: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.all(30),
      hintStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,

      ),
      border:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.white,
          width: 0.4,
        )
      ),
      enabledBorder : OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.white,
          width: 0.4,
        )
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        )
      )
    )
  );
}