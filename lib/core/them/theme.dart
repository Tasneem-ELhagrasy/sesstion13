import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sesstion13/core/utils/app_colors.dart';

ThemeData getAppTheme() {
  return ThemeData(
      primaryColor: AppColors.purple,
      // background color
      scaffoldBackgroundColor: AppColors.background,
      // appBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        centerTitle: true,
      ),
      // textTheme
      textTheme: TextTheme(
        displayLarge: GoogleFonts.lato(
          color: AppColors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.lato(
          color: AppColors.white,
          fontSize: 16,
        ),
        displaySmall: GoogleFonts.lato(
          color: AppColors.white.withOpacity(.44),
          fontSize: 16,
        ),
      ),
      // bottom theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintStyle: GoogleFonts.lato(
          color: AppColors.white,
          fontSize: 16,
        ),
        fillColor: AppColors.deepBlack,
        filled: true,
      ));
}
