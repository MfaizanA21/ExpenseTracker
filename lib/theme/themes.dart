import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.grey[650], // Soft teal for primary color
  scaffoldBackgroundColor: Colors.grey[400], // Light background
  appBarTheme: AppBarTheme(
    color: Colors.grey[500], // Teal for the app bar
    iconTheme: IconThemeData(color: Colors.white), // White icons
    elevation: 1, // Minimal elevation for a subtle effect
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black87), // Dark text
    bodyMedium: TextStyle(color: Colors.black54), // Medium dark text
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.grey[700]!, // Teal for primary
    onPrimary: Colors.white60,
    secondary: Colors.green, // Warm amber for secondary
    onSecondary: Colors.black87,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.grey[600]), // Grey label style
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[300]!), // Light grey for border
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.teal[700]!), // Teal border when focused
    ),
  ),
  cardColor: Colors.white60, // White background for cards
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.teal[300], // Soft teal for primary
  scaffoldBackgroundColor: Colors.grey[900], // Very dark grey for background
  appBarTheme: AppBarTheme(
    color: Colors.teal[700], // Darker teal for the app bar
    iconTheme: IconThemeData(color: Colors.white70), // Slightly muted white icons
    elevation: 0, // No elevation for a flat look
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white70), // Muted white text
    bodyMedium: TextStyle(color: Colors.white60), // Slightly lighter white for secondary text
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.teal[300]!, // Teal for primary
    onPrimary: Colors.black87,
    secondary: Colors.amber[200]!, // Warm amber for secondary
    onSecondary: Colors.black87,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.grey[400]), // Light grey label style
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[600]!), // Medium grey for border
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.teal[300]!), // Teal border when focused
    ),
  ),
  cardColor: Colors.grey[850], // Dark grey background for cards
);
