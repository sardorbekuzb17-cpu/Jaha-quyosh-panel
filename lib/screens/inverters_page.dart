import 'package:flutter/material.dart';
import '../models/inverter_model.dart';
import '../widgets/inverter_card.dart';
import '../utils/text_styles.dart';
import '../widgets/animated_card.dart';
import '../widgets/fade_in_text.dart';
import '../utils/app_colors.dart';
import '../widgets/loading_animation.dart';
import 'order_screen.dart';

class InvertersPage extends StatefulWidget {
  const InvertersPage({Key? key}) : super(key: key);

  @override
  State<InvertersPage> createState() => _InvertersPageState();
}

class _InvertersPageState extends State<InvertersPage> {
  List<Inverter> _inverters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInverters();
  }

  Future<void> _loadInverters() async {
    setState(() => _isLoading = true);
    // Ma'lumotlarni markazlashtirilgan manbadan yuklash
    await Future.delayed(const Duration(milliseconds: 500)); // Simulating network delay
    try {
      setState(() {
        _inverters = InverterData.getInverters();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Inverterlarni yuklashda xatolik yuz berdi')),
        );
      }
    }
  }

  void _showInverterDetails(Inverter inverter) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          child: FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) =>
          InverterDetailsView(inverter: inverter),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = (screenWidth / 350).floor().clamp(1, 4);

    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: LoadingAnimation(
            color: AppColors.primary,
            size: 60,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inverterlar', // Removed style to use default AppBar theme
        ),
        backgroundColor: AppColors.primaryDark,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.backgroundLight,
              AppColors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInText(
                text: 'Professional Inverterlar',
                style: TextStyles.heroTitle().copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 8),
              FadeInText(
                delay: const Duration(milliseconds: 200),
                text: 'Yuqori samarali va ishonchli inverterlar',
                style: TextStyles.bodyText().copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: screenWidth < 600 ? 0.75 : 0.85,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  itemCount: _inverters.length,
                  itemBuilder: (context, index) {
                    return AnimatedCard(
                      duration: Duration(milliseconds: 400 + (index * 100)),
                      child: InverterCard(
                        inverter: _inverters[index],
                        onTap: () => _showInverterDetails(_inverters[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Inverter haqida batafsil ma'lumot ko'rsatadigan dialog vidjeti.
class InverterDetailsView extends StatelessWidget {
  final Inverter inverter;

  const InverterDetailsView({Key? key, required this.inverter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rasm
              AnimatedCard(
                duration: const Duration(milliseconds: 500),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    inverter.imageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.contain, // Changed from cover to contain
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Nomi
              FadeInText(
                text: inverter.name,
                style: TextStyles.heroTitle().copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                ),
                delay: const Duration(milliseconds: 100),
              ),
              const SizedBox(height: 16),
              // Tavsif
              FadeInText(
                text: inverter.description,
                style: TextStyles.bodyText().copyWith(
                  color: AppColors.textSecondary,
                ),
                delay: const Duration(milliseconds: 200),
              ),
              const SizedBox(height: 24),
              // Texnik xususiyatlar
              FadeInText(
                text: 'Texnik xususiyatlar:',
                style: TextStyles.subTitle().copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                ),
                delay: const Duration(milliseconds: 300),
              ),
              const SizedBox(height: 16),
              // Display inverter features
              ...inverter.features.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_right, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: TextStyles.feature().copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
              // Tugma
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Yopish'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Dialogni yopish
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderScreen(preSelectedInverter: inverter.name),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Buyurtma berish'),
                  ),
                ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}