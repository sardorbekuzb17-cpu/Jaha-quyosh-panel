import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  // Asosiy sarlavha uchun
  static TextStyle heroTitle({Color? color}) {
    return GoogleFonts.montserrat(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.5,
      height: 1.2,
      color: color ?? Colors.white,
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    );
  }

  // Kichik sarlavha uchun
  static TextStyle subTitle({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      height: 1.4,
      color: color ?? Colors.white.withOpacity(0.9),
    );
  }

  // Asosiy matn uchun
  static TextStyle bodyText({Color? color}) {
    return GoogleFonts.rubik(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      height: 1.6,
      color: color ?? Colors.white.withOpacity(0.8),
    );
  }

  // Maxsus elementlar uchun
  static TextStyle feature({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.3,
      height: 1.5,
      color: color ?? Colors.white.withOpacity(0.95),
    );
  }

  // Tugmalar uchun
  static TextStyle button({Color? color}) {
    return GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.0,
      height: 1.0,
      color: color ?? Colors.white,
    );
  }

  // Narxlar uchun
  static TextStyle price({Color? color}) {
    return GoogleFonts.dmSans(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      height: 1.3,
      color: color ?? Colors.white,
    );
  }
}