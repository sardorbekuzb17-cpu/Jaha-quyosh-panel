import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const TypewriterText({
    Key? key,
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 100),
  }) : super(key: key);

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late String _text;
  late int _charCount;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _text = '';
    _charCount = 0;
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        if (_charCount < widget.text.length) {
          _text += widget.text[_charCount];
          _charCount++;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: widget.style,
    );
  }
}