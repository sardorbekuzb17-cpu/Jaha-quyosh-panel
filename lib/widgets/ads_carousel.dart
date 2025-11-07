import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class AdsCarousel extends StatefulWidget {
  const AdsCarousel({Key? key}) : super(key: key);

  @override
  _AdsCarouselState createState() => _AdsCarouselState();
}

class _AdsCarouselState extends State<AdsCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  List<Map<String, String>> _availableAds = [];

  @override
  void initState() {
    super.initState();
    _loadAvailableAds();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_availableAds.isNotEmpty) {
        final nextIndex = (_currentIndex + 1) % _availableAds.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _loadAvailableAds() {
    // Reklama ma'lumotlari
    _availableAds = [
      {
        'title': 'LONGi Solar Panellari',
        'subtitle': 'Jahon yetakchi brendi',
        'image': 'assets/images/ads/1.jpg',
      },
      {
        'title': 'LONGi - Ishonch Ramzi',
        'subtitle': 'Premium sifat kafolati',
        'image': 'assets/images/ads/2.jpg',
      },
      {
        'title': 'Katta Loyihalar',
        'subtitle': 'Yuqori quvvatli tizimlar',
        'image': 'assets/images/ads/3.jpg',
      },
      {
        'title': 'Samarali Energiya',
        'subtitle': 'Maksimal unumdorlik',
        'image': 'assets/images/ads/4.jpg',
      },
      {
        'title': 'LONGi Mahsulotlari',
        'subtitle': 'Turli quvvatdagi panellar',
        'image': 'assets/images/ads/5.jpg',
      },
      {
        'title': 'LONGi Brendi',
        'subtitle': 'Dunyo bo\'ylab ishonch',
        'image': 'assets/images/ads/6.jpg',
      },
      {
        'title': 'LONGi Solar Fermalari',
        'subtitle': 'Katta hajmli loyihalar',
        'image': 'assets/images/ads/7.jpg',
      },
      {
        'title': 'Quyosh Paneli Aksiyasi',
        'subtitle': '30% chegirma bilan!',
        'image': 'assets/images/ads/photo_1_2025-11-06_14-06-18.jpg',
      },
      {
        'title': 'Kafolat 25 Yil',
        'subtitle': 'Ishonchli hamkorlik',
        'image': 'assets/images/ads/photo_5_2025-11-06_14-06-18.jpg',
      },
      {
        'title': 'Premium Panellar',
        'subtitle': 'Eng yaxshi sifat',
        'image': 'assets/images/ads/photo_6_2025-11-06_14-06-18.jpg',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_availableAds.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // PageView Slider
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _availableAds.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final ad = _availableAds[index];
                return _buildAdCard(ad, index);
              },
            ),
          ),

          const SizedBox(height: 15),

          // Smooth Page Indicator
          SmoothPageIndicator(
            controller: _pageController,
            count: _availableAds.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.blue[700]!,
              dotColor: Colors.grey[400]!,
            ),
            onDotClicked: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdCard(Map<String, String> ad, int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFF1F5F9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.15),
            spreadRadius: 3,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              ad['image']!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Agar rasm topilmasa, gradient background
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue[400]!,
                        Colors.blue[700]!,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.solar_power,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),

            // Text Content
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ad['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    ad['subtitle']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tap Detector
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _onAdTapped(index),
                  borderRadius: BorderRadius.circular(15),
                  child: Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAdTapped(int index) {
    // Reklama bosilganda nima qilish kerak
    final ad = _availableAds[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(ad['title']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ad['subtitle']!),
              const SizedBox(height: 16),
              const Text('Batafsil ma\'lumot uchun biz bilan bog\'laning:'),
              const SizedBox(height: 8),
              const Text('📞 +998 93 087 47 58'),
              const Text('✈️ @jahonbas'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Yopish'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final Uri phoneUri = Uri(scheme: 'tel', path: '+998930874758');
                if (await canLaunchUrl(phoneUri)) {
                  await launchUrl(phoneUri);
                }
              },
              child: const Text('Bog\'lanish'),
            ),
          ],
        );
      },
    );
  }
}
