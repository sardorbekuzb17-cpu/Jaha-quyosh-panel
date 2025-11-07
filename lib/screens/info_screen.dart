import 'package:flutter/material.dart';
import '../widgets/ads_carousel.dart';
import 'video_player_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  void _openYouTubeVideo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VideoPlayerScreen(
          videoId: 'K3Z-aETHPng',
          title: 'Quyosh Paneli O\'rnatish',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quyosh Energiyasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 20),

            // Reklama Carousel
            const AdsCarousel(),

            const SizedBox(height: 30),

            // Video Qo'llanmalar
            Text(
              'Video Qo\'llanmalar',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 15),

            // Video 1
            _buildVideoCard(
              context,
              title: 'Quyosh Paneli O\'rnatish',
              description:
                  'Quyosh panelini qanday o\'rnatish haqida to\'liq qo\'llanma',
              thumbnail: '🎬',
              onTap: () => _openYouTubeVideo(context),
            ),

            const SizedBox(height: 15),

            // Video 2
            _buildVideoCard(
              context,
              title: 'Quyosh Energiyasi Tizimi',
              description: 'Quyosh energiyasi tizimining ishlash prinsipi',
              thumbnail: '📹',
              onTap: () => _openSecondVideo(context),
            ),

            const SizedBox(height: 15),

            // Video 3
            _buildVideoCard(
              context,
              title: 'Quyosh Paneli Texnik Xizmati',
              description: 'Quyosh panellariga texnik xizmat ko\'rsatish',
              thumbnail: '🎥',
              onTap: () => _openThirdVideo(context),
            ),

            const SizedBox(height: 15),

            // Video 4
            _buildVideoCard(
              context,
              title: 'Quyosh Energiyasi Afzalliklari',
              description: 'Quyosh energiyasining foydali tomonlari',
              thumbnail: '☀️',
              onTap: () => _openFourthVideo(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(
    BuildContext context, {
    required String title,
    required String description,
    required String thumbnail,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red[700]!, Colors.red[500]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  thumbnail,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(
                        Icons.play_circle_filled,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Video ko\'rish',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _openSecondVideo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VideoPlayerScreen(
          videoId: '0EEC9Gh9F9U',
          title: 'Quyosh Energiyasi Tizimi',
        ),
      ),
    );
  }

  void _openThirdVideo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VideoPlayerScreen(
          videoId: '0EEC9Gh9F9U',
          title: 'Quyosh Paneli Texnik Xizmati',
        ),
      ),
    );
  }

  void _openFourthVideo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VideoPlayerScreen(
          videoId: 'wq2zyAsWluc',
          title: 'Quyosh Energiyasi Afzalliklari',
        ),
      ),
    );
  }
}
