import 'package:flutter/material.dart';

/// Ilova uchun markazlashtirilgan ranglar palitrasi.
/// Bu klass ranglarni bir joyda saqlash va butun ilova bo'ylab
/// bir xil uslubni ta'minlash uchun ishlatiladi.
class AppColors {
  // Asosiy ranglar (Primary)
  static const Color primary = Color(0xFF1976D2); // Asosiy ko'k rang (Colors.blue[700])
  static const Color primaryDark = Color(0xFF0D47A1); // To'q ko'k (Colors.blue[900])
  static const Color primaryLight = Color(0xFF42A5F5); // Ochiq ko'k (Colors.blue[500])
  static const Color primaryVeryLight = Color(0xFFE3F2FD); // Eng ochiq ko'k (Colors.blue[50])

  // Qo'shimcha ranglar (Accent/Secondary)
  static const Color accentOrange = Color(0xFFFB8C00); // To'q sariq (Colors.orange[600])
  static const Color accentYellow = Color(0xFFFFD600); // Sariq (Colors.yellow[700])
  static const Color accentGreen = Color(0xFF4CAF50); // Yashil (Colors.green)

  // Fon ranglari (Background)
  static const Color backgroundLight = Color(0xFFF5F5F5); // Ochiq kulrang fon (Colors.grey[100])
  static const Color backgroundDark = Color(0xFF212121); // To'q kulrang fon (Colors.grey[900])
  static const Color white = Colors.white; // Oq

  // Matn ranglari (Text)
  static const Color textPrimary = Color(0xFF212121); // Asosiy qora matn (Colors.black87)
  static const Color textSecondary = Color(0xFF757575); // Ikkilamchi kulrang matn (Colors.grey[600])
  static const Color textWhite = Colors.white; // Oq matn

  // Status ranglari
  static const Color success = Color(0xFF4CAF50); // Muvaffaqiyatli (yashil)
  static const Color error = Color(0xFFD32F2F); // Xatolik (qizil)
  static const Color warning = Color(0xFFFFA000); // Ogohlantirish (sariq)

  // Gradientlar
  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryDark, primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient secondaryGradient = LinearGradient(
    colors: [accentOrange, accentYellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}