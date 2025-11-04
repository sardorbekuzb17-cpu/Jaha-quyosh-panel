import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

class AdsCarousel extends StatefulWidget {
  const AdsCarousel({Key? key}) : super(key: key);

  @override
  _AdsCarouselState createState() => _AdsCarouselState();
}

class _AdsCarouselState extends State<AdsCarousel> {
  int _currentIndex = 0;
  final cs.CarouselController _carouselController = cs.CarouselController();
  List<Map<String, String>> _availableAds = [];

  @override
  void initState() {
    super.initState();
    _loadAvailableAds();
  }

  void _loadAvailableAds() {
    // Faqat mavjud rasmlar uchun ad data yaratish
    _availableAds = _adData.take(5).toList(); // Birinchi 5 ta rasm
  }

  // Reklama rasmlari ro'yxati - barcha formatlarni qo'llab-quvvatlash
  List<String> get _adImages {
    List<String> images = [];

    // JPG formatdagi rasmlar
    for (int i = 1; i <= 10; i++) {
      images.add('assets/images/ads/ad$i.jpg');
    }

    // PNG formatdagi rasmlar
    for (int i = 1; i <= 10; i++) {
      images.add('assets/images/ads/ad$i.png');
    }

    // JPEG formatdagi rasmlar
    for (int i = 1; i <= 10; i++) {
      images.add('assets/images/ads/ad$i.jpeg');
    }

    return images;
  }

  // Reklama matnlari - dinamik generatsiya
  List<Map<String, String>> get _adData {
    final titles = [
      'Quyosh Paneli Aksiyasi',
      'Yangi Inverterlar',
      'Tekin Konsultatsiya',
      'O\'rnatish Xizmati',
      'Kafolat 25 Yil',
      'Premium Panellar',
      'Energiya Tejash',
      'Ekologik Yechim',
      'Sifatli Xizmat',
      'Arzon Narxlar',
    ];

    final subtitles = [
      '30% chegirma bilan!',
      'Yuqori sifat, arzon narx',
      'Mutaxassislarimiz bilan',
      'Professional jamoa',
      'Ishonchli hamkorlik',
      'Eng yaxshi brendlar',
      'Elektr to\'lovini kamaytiring',
      'Tabiatni asrang',
      'Kafolat va xizmat',
      'Hamyonbop takliflar',
    ];

    List<Map<String, String>> data = [];

    for (String imagePath in _adImages) {
      // Rasm nomidan index olish
      final fileName = imagePath.split('/').last.split('.').first;
      final numberMatch = RegExp(r'\d+').firstMatch(fileName);
      final index =
          numberMatch != null ? int.parse(numberMatch.group(0)!) - 1 : 0;

      data.add({
        'title': titles[index % titles.length],
        'subtitle': subtitles[index % subtitles.length],
        'image': imagePath,
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Carousel Slider
          cs.CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: _availableAds.length,
            itemBuilder: (context, index, realIndex) {
              final ad = _availableAds[index];
              return _buildAdCard(ad, index);
            },
            options: cs.CarouselOptions(
              height: 220,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3), // Tezroq aylanish
              autoPlayAnimationDuration:
                  const Duration(milliseconds: 1000), // Smooth animation
              autoPlayCurve: Curves.easeInOutCubic, // Yaxshi curve
              enlargeCenterPage: true,
              enlargeFactor: 0.25, // Ko'proq kattalashtirish
              viewportFraction: 0.85, // Yonidagi rasmlar ko'rinsin
              aspectRatio: 16 / 9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              scrollDirection: Axis.horizontal,
              pauseAutoPlayOnTouch: true, // Touch qilganda to'xtatish
              pauseAutoPlayOnManualNavigate:
                  true, // Manual navigate qilganda to'xtatish
              pauseAutoPlayInFiniteScroll:
                  false, // Infinite scroll'da davom etish
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),

          const SizedBox(height: 15),

          // Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _availableAds.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: Container(
                  width: _currentIndex == entry.key ? 12 : 8,
                  height: _currentIndex == entry.key ? 12 : 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? Colors.blue[700]
                        : Colors.grey[400],
                  ),
                ),
              );
            }).toList(),
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
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
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
              const Text('📧 @jahonbas'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Yopish'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Bu yerda telefon qo'ng'irog'i yoki boshqa action
              },
              child: const Text('Bog\'lanish'),
            ),
          ],
        );
      },
    );
  }
}
