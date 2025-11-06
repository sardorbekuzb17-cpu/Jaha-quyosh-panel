import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../utils/text_styles.dart';

class StylizedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final bool animate;
  final bool gradient;
  final bool outline;

  const StylizedText({
    Key? key,
    required this.text,
    required this.style,
    this.animate = false,
    this.gradient = false,
    this.outline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textWidget;

    if (animate) {
      textWidget = AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            text,
            textStyle: style,
            speed: const Duration(milliseconds: 100),
          ),
        ],
        isRepeatingAnimation: false,
      );
    } else {
      textWidget = Text(text, style: style);
    }

    if (gradient) {
      textWidget = ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            colors: [
              Color(0xFF64B5F6), // Light Blue
              Color(0xFF1976D2), // Blue
              Color(0xFF0D47A1), // Dark Blue
            ],
            stops: [0.0, 0.5, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: textWidget,
      );
    }

    if (outline) {
      return Stack(
        children: [
          // Outline effect
          Text(
            text,
            style: style.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = Colors.blue[900]!,
            ),
          ),
          // Main text
          textWidget,
        ],
      );
    }

    return textWidget;
  }
}