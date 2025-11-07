import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  // Main title style
  static TextStyle heroTitle({Color? color}) {
    return GoogleFonts.montserrat(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.5,
      height: 1.2,
      color: color ?? Colors.white,
      shadows: [
        Shadow(
          color: Colors.black.withAlpha(25),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    );
  }

  // Subtitle style
  static TextStyle subTitle({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      height: 1.4,
      color: color ?? Colors.white.withAlpha(230),
    );
  }

  // Feature text style
  static TextStyle feature({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.3,
      height: 1.5,
      color: color ?? Colors.white.withAlpha(242),
    );
  }
}
