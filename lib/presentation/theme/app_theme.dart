import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportify_app/utils/app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.background,
        surface: AppColors.secondary,
        error: AppColors.error,
        onPrimary: AppColors.text,
        onSecondary: AppColors.text,
        onBackground: AppColors.text,
        onSurface: AppColors.text,
        onError: AppColors.text,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge:
              TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
          displayMedium:
              TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
          displaySmall:
              TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
          headlineLarge:
              TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
          headlineMedium:
              TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
          headlineSmall:
              TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
          titleLarge:
              TextStyle(color: AppColors.text, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: AppColors.textSecondary),
          titleSmall: TextStyle(color: AppColors.textSecondary),
          bodyLarge: TextStyle(color: AppColors.textSecondary),
          bodyMedium: TextStyle(color: AppColors.textSecondary),
          bodySmall: TextStyle(color: AppColors.textTertiary),
          labelLarge: TextStyle(
              color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondary,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: AppColors.textTertiary),
        prefixIconColor: AppColors.textTertiary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
