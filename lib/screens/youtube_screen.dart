import 'package:flutter/material.dart';
import 'video_player_screen.dart';

class YouTubeScreen extends StatelessWidget {
  const YouTubeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFE2E8F0),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sarlavha
              Container(
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
                child: const Row(
                  children: [
                    Icon(Icons.play_circle_filled, color: Colors.white, size: 30),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'YouTube Video Qo\'llanmalar',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Video 1
              _buildVideoCard(
                context,
                title: 'Quyosh Paneli O\'rnatish',
                description: 'Quyosh panelini qanday o\'rnatish haqida to\'liq qo\'llanma',
                thumbnail: '🎬',
                duration: '15:30',
                views: '12K',
                onTap: () => _openVideo(context, 'K3Z-aETHPng', 'Quyosh Paneli O\'rnatish'),
              ),

              const SizedBox(height: 15),

              // Video 2
              _buildVideoCard(
                context,
                title: 'Quyosh Energiyasi Tizimi',
                description: 'Quyosh energiyasi tizimining ishlash prinsipi',
                thumbnail: '📹',
                duration: '12:45',
                views: '8.5K',
                onTap: () => _openVideo(context, '0EEC9Gh9F9U', 'Quyosh Energiyasi Tizimi'),
              ),

              const SizedBox(height: 15),

              // Video 3
              _buildVideoCard(
                context,
                title: 'Quyosh Paneli Texnik Xizmati',
                description: 'Quyosh panellariga texnik xizmat ko\'rsatish',
                thumbnail: '🎥',
                duration: '18:20',
                views: '6.2K',
                onTap: () => _openVideo(context, '0EEC9Gh9F9U', 'Quyosh Paneli Texnik Xizmati'),
              ),

              const SizedBox(height: 15),

              // Video 4
              _buildVideoCard(
                context,
                title: 'Quyosh Energiyasi Afzalliklari',
                description: 'Quyosh energiyasining foydali tomonlari',
                thumbnail: '☀️',
                duration: '10:15',
                views: '15K',
                onTap: () => _openVideo(context, 'wq2zyAsWluc', 'Quyosh Energiyasi Afzalliklari'),
              ),

              const SizedBox(height: 15),

              // Video 5
              _buildVideoCard(
                context,
                title: 'LONGi Solar Panellari',
                description: 'LONGi brendining eng yaxshi panellari',
                thumbnail: '🌟',
                duration: '14:50',
                views: '9.8K',
                onTap: () => _openVideo(context, 'K3Z-aETHPng', 'LONGi Solar Panellari'),
              ),

              const SizedBox(height: 15),

              // Video 6
              _buildVideoCard(
                context,
                title: 'Inverter Tanlash',
                description: 'To\'g\'ri inverter qanday tanlanadi',
                thumbnail: '⚡',
                duration: '11:30',
                views: '7.1K',
                onTap: () => _openVideo(context, '0EEC9Gh9F9U', 'Inverter Tanlash'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(
    BuildContext context, {
    required String title,
    required String description,
    required String thumbnail,
    required String duration,
    required String views,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red[400]!, Colors.red[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      thumbnail,
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 15),
            
            // Ma'lumotlar
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.visibility, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        '$views ko\'rishlar',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Icon(Icons.play_circle_outline, size: 14, color: Colors.red[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Ko\'rish',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _openVideo(BuildContext context, String videoId, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
          videoId: videoId,
          title: title,
        ),
      ),
    );
  }
}