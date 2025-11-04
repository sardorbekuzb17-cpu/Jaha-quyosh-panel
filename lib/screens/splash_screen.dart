import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _backgroundController;
  late AnimationController _particleController;
  late AnimationController _pulseController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _textSlideAnimation;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller larni yaratish
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Logo animatsiyalari
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));

    // Matn animatsiyalari
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));

    _textSlideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    // Background animatsiyasi
    _backgroundColorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.blue[50],
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));

    // Particle animatsiyasi
    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.easeInOut,
    ));

    // Pulse animatsiyasi
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Animatsiyalarni boshlash
    _startAnimations();
  }

  void _startAnimations() async {
    // Background animatsiyasini boshlash
    _backgroundController.forward();

    // Particle animatsiyasini boshlash
    _particleController.repeat();

    // 300ms kutib logo animatsiyasini boshlash
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    // Pulse animatsiyasini boshlash
    _pulseController.repeat(reverse: true);

    // 800ms kutib matn animatsiyasini boshlash
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    // Jami 3 soniya kutib keyingi sahifaga o'tish
    Timer(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HomeScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _logoController,
        _textController,
        _backgroundController,
      ]),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [
                  Colors.blue[900]!.withValues(alpha: 0.8),
                  Colors.blue[800]!.withValues(alpha: 0.6),
                  Colors.indigo[900]!.withValues(alpha: 0.9),
                  Colors.black,
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Animated particles background
                _buildParticles(),

                // Main content
                _buildMainContent(),
              ],
            ),
          ),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    // Agar logo.png mavjud bo'lsa, uni ishlatamiz, aks holda icon
    return FutureBuilder<bool>(
      future: _checkLogoExists(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          // Logo rasm mavjud
          return ClipOval(
            child: Image.asset(
              'assets/images/logo.png',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildDefaultIcon();
              },
            ),
          );
        } else {
          // Default icon
          return _buildDefaultIcon();
        }
      },
    );
  }

  Widget _buildDefaultIcon() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _logoRotationAnimation.value * 6.28, // 360 daraja
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.yellow[300]!,
                  Colors.orange[400]!,
                  Colors.blue[600]!,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
            child: const Icon(
              Icons.wb_sunny,
              size: 60,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Future<bool> _checkLogoExists() async {
    try {
      // Logo mavjudligini tekshirish
      // Agar assets/images/logo.png mavjud bo'lsa true qaytaradi

      // Hozircha default icon ishlatamiz
      // Logo qo'shgandan so'ng bu qatorni o'zgartiring:
      // return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }
}
