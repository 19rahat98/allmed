import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const gray = Color(0xFFABB0BC);
  static const black = Color(0xFF0D0D0D);
  static const error = Color(0xFFF63B3B);
  static const red = Color(0xFFD32929);
  static const lightGray = Color(0xFFDBDBDB);
  static const secondary = Color(0xFF5AC2D7);
  static const primaryColor = Color(0xFF0692A1);
  static const superGray = Color(0xFFFAFAFA);
  static const rdBlack = Color(0xFF1F2021);
}

class AppThemeConstants {
  static const MaterialAccentColor accentColor = MaterialAccentColor(
    0xFF0692A1,
    <int, Color>{
      100: Color(0xFF0692A1),
      200: Color(0xFF0692A1),
      400: Color(0xFF0692A1),
      700: Color(0xFF0692A1),
    },
  );
}

class AppTextStyle {
  static const navBar = TextStyle(
    fontSize: 11,
    fontFamily: 'Inter',
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );

  static final base = GoogleFonts.ubuntu(
    fontSize: 14,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );

  static final buttonStyle = GoogleFonts.ubuntu(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  static final biggest = GoogleFonts.inter(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColor,
  );

  static final caption1 = GoogleFonts.ubuntu(
    fontSize: 16,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );

  static final secondary = GoogleFonts.ubuntu(
    fontSize: 12,
    color: AppColors.gray,
    fontWeight: FontWeight.w500,
  );

  static final title2 = GoogleFonts.ubuntu(
    fontSize: 18,
    color: AppColors.black,
    fontWeight: FontWeight.w700,
  );

  static final title1 = GoogleFonts.ubuntu(
    fontSize: 22,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
}
