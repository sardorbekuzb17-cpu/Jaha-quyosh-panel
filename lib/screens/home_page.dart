import 'package:flutter/material.dart';
import '../widgets/animated_gradient_text.dart';
import '../widgets/typewriter_text.dart';
import '../widgets/fade_in_text.dart';
import '../widgets/stylized_text.dart';
import '../utils/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[900]!,
              Colors.blue[700]!,
              Colors.blue[500]!,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: StylizedText(
                    text: 'Quyosh24',
                    style: TextStyles.heroTitle(),
                    gradient: true,
                    outline: true,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: StylizedText(
                    text: 'Energiya tejash yechimi',
                    style: TextStyles.subTitle(),
                    animate: true,
                  ),
                ),
                const SizedBox(height: 48),
                FadeInText(
                  text: 'Quyosh energiyasi - kelajak energiyasi',
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  delay: const Duration(milliseconds: 500),
                ),
                const SizedBox(height: 24),
                FadeInText(
                  text: 'Bizning afzalliklarimiz:',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  delay: const Duration(milliseconds: 1000),
                ),
                const SizedBox(height: 16),
                _buildFeatureList(),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to pricing page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Narxlarni ko\'rish',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      {'icon': '🌟', 'text': 'Professional o\'rnatish'},
      {'icon': '⚡', 'text': 'Yuqori sifatli panellar'},
      {'icon': '🛡️', 'text': '25 yillik kafolat'},
      {'icon': '💳', 'text': 'Qulay to\'lov usullari'},
      {'icon': '🔧', 'text': '24/7 texnik yordam'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: features.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    entry.value['icon']!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StylizedText(
                    text: entry.value['text']!,
                    style: TextStyles.feature(),
                    animate: true,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
