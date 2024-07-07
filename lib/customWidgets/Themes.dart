import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeManager {
  static ThemeData LightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    cardColor: Colors.grey.shade200,
    scaffoldBackgroundColor: Colors.deepPurple,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Background color
        foregroundColor: Colors.deepPurple, // Text and icon color
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: Colors.deepPurple),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade200,
    ),
    // Set other required fields with default values or as per your needs
    canvasColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    disabledColor: Colors.grey,
    dividerColor: Colors.grey,
    focusColor: Colors.deepPurple.withOpacity(0.12),
    highlightColor: Colors.deepPurple.withOpacity(0.12),
    hintColor: Colors.grey,
    hoverColor: Colors.deepPurple.withOpacity(0.04),
    indicatorColor: Colors.deepPurple,
    secondaryHeaderColor: Colors.deepPurple.shade50,
    shadowColor: Colors.black,
    splashColor: Colors.deepPurple.withOpacity(0.12),
    unselectedWidgetColor: Colors.grey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    typography: Typography.material2018(),
    fontFamily: 'Roboto',
  );
}
