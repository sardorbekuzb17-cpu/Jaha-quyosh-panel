import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class PricingCard extends StatefulWidget {
  final Map<String, dynamic> package;
  final VoidCallback onOrderNow;
  final bool isPopular;

  const PricingCard({
    Key? key,
    required this.package,
    required this.onOrderNow,
    this.isPopular = false,
  }) : super(key: key);

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatPrice(int price) {
    return '${price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )} so\'m';
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              gradient: _isHovered || widget.isPopular
                  ? AppTheme.gradientPrimary
                  : null,
              color: _isHovered || widget.isPopular
                  ? null
                  : Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: (_isHovered || widget.isPopular
                      ? Colors.blue[900]!
                      : Colors.grey[300]!)
                      .withOpacity(_isHovered ? 0.3 : 0.1),
                  blurRadius: _isHovered ? 20 : 10,
                  offset: Offset(0, _isHovered ? 10 : 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.isPopular)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Eng mashhur',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.package['name'],
                        style: AppTheme.headingStyle.copyWith(
                          color: _isHovered || widget.isPopular
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _formatPrice(widget.package['price']),
                        style: AppTheme.priceStyle.copyWith(
                          color: _isHovered || widget.isPopular
                              ? AppTheme.colorScheme.secondary
                              : AppTheme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ...widget.package['includes'].map<Widget>((feature) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: _isHovered || widget.isPopular
                                      ? Colors.white.withOpacity(0.2)
                                      : AppTheme.colorScheme.primary
                                          .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 16,
                                  color: _isHovered || widget.isPopular
                                      ? Colors.white
                                      : AppTheme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                    color: _isHovered || widget.isPopular
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: widget.onOrderNow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isHovered || widget.isPopular
                                ? Colors.white
                                : AppTheme.colorScheme.primary,
                            foregroundColor: _isHovered || widget.isPopular
                                ? AppTheme.colorScheme.primary
                                : Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Buyurtma berish',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}