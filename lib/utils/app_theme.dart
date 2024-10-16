import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
    ),
    cardTheme: const CardTheme(
      surfaceTintColor: AppColors.containerColor,
      color: AppColors.containerColor,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.secondaryColor,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.containerColor,
      secondary: AppColors.secondaryColor,
      tertiary: AppColors.tertiaryColor,
    ),
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      contentPadding: const EdgeInsets.all(10),
      fillColor: AppColors.containerColor,
      filled: true,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
      ),
    ),
  );
}
