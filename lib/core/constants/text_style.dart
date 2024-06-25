import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybidan/core/constants/colors.dart';

class CustomTextStyle {
  static TextStyle bigText = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static TextStyle greenText = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColors.primary,
  );
  static TextStyle smText = GoogleFonts.poppins(
    fontSize: 10,
    color: Colors.white,
  );
  static TextStyle biggerText = GoogleFonts.poppins(
    fontSize: 22,
    color: Colors.white,
  );
  static TextStyle smallerText = GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.white,
  );
  static TextStyle primaryText = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black,
  );
}
