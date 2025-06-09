import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportify_app/utils/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
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
      brightness: Brightness.dark,
      textTheme: _buildTextTheme(base: ThemeData.dark().textTheme),
      inputDecorationTheme: _buildInputDecorationTheme(isDark: true),
      elevatedButtonTheme: _buildElevatedButtonThemeData(),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.lightSecondary,
        background: AppColors.lightBackground,
        surface: AppColors.lightSecondary,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: AppColors.lightText,
        onBackground: AppColors.lightText,
        onSurface: AppColors.lightText,
        onError: Colors.white,
      ),
      brightness: Brightness.light,
      textTheme: _buildTextTheme(base: ThemeData.light().textTheme),
      inputDecorationTheme: _buildInputDecorationTheme(isDark: false),
      elevatedButtonTheme: _buildElevatedButtonThemeData(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.lightText),
        titleTextStyle: TextStyle(
          color: AppColors.lightText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.lightText),
    );
  }

  static TextTheme _buildTextTheme({required TextTheme base}) {
    return GoogleFonts.poppinsTextTheme(
      base.copyWith(
        displayLarge: base.displayLarge?.copyWith(fontWeight: FontWeight.bold),
        displayMedium:
            base.displayMedium?.copyWith(fontWeight: FontWeight.bold),
        displaySmall: base.displaySmall?.copyWith(fontWeight: FontWeight.bold),
        headlineLarge:
            base.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        headlineMedium:
            base.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        headlineSmall:
            base.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        labelLarge: base.labelLarge
            ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(
      {required bool isDark}) {
    return InputDecorationTheme(
      filled: true,
      fillColor: isDark ? AppColors.secondary : AppColors.lightSecondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
          color: isDark ? AppColors.textTertiary : Colors.grey.shade600),
      prefixIconColor: isDark ? AppColors.textTertiary : Colors.grey.shade600,
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white, // Text color for buttons
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
