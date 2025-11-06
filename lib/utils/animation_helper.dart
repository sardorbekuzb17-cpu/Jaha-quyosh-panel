import 'package:flutter/material.dart';

class AnimationHelper {
  // Fade animatsiyasi
  static Widget fadeAnimation({
    required Widget child,
    required Animation<double> animation,
  }) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  // Scale animatsiyasi
  static Widget scaleAnimation({
    required Widget child,
    required Animation<double> animation,
  }) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }

  // Slide animatsiyasi
  static Widget slideAnimation({
    required Widget child,
    required Animation<Offset> animation,
  }) {
    return SlideTransition(
      position: animation,
      child: child,
    );
  }
}

// Maxsus animatsiya effektlari
class CustomAnimations {
  // Bounce effekti
  static Animation<double> bounceAnimation(AnimationController controller) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ),
    );
  }

  // Pulse effekti
  static Animation<double> pulseAnimation(AnimationController controller) {
    return Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  // Fade In Up effekti
  static Animation<Offset> fadeInUpAnimation(AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );
  }
}