import 'package:flutter/material.dart';
import '../models/inverter_model.dart';
import '../services/currency_service.dart';

class InverterCard extends StatefulWidget {
  final Inverter inverter;
  final VoidCallback onTap;

  const InverterCard({
    Key? key,
    required this.inverter,
    required this.onTap,
  }) : super(key: key);

  @override
  State<InverterCard> createState() => _InverterCardState();
}

class _InverterCardState extends State<InverterCard> {
  final CurrencyService _currencyService = CurrencyService();
  double _uzsPrice = 0;
  double _usdRate = 12700;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrice();
  }

  Future<void> _loadPrice() async {
    try {
      final rate = await _currencyService.getUsdRate();
      final uzsPrice = await _currencyService.usdToUzs(widget.inverter.price);

      setState(() {
        _usdRate = rate;
        _uzsPrice = uzsPrice;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _usdRate = _currencyService.getCachedRate();
        _uzsPrice = widget.inverter.price * _usdRate;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Rasm
          _buildImage(),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.inverter.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[900],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.inverter.description,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Narxi:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        if (_isLoading)
                          const SizedBox(
                            width: 100,
                            height: 24,
                            child: LinearProgressIndicator(),
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${(_uzsPrice / 1000000).toStringAsFixed(1)}M',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[900],
                                ),
                              ),
                              Text(
                                '\$${widget.inverter.price.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Quvvati:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${widget.inverter.power.toStringAsFixed(0)} kW',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    // Agar imageUrl bo'sh bo'lsa, placeholder ko'rsatamiz
    if (widget.inverter.imageUrl.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: const Center(
          child: Icon(
            Icons.electrical_services,
            size: 80,
            color: Colors.orange,
          ),
        ),
      );
    }

    // Agar imageUrl bor bo'lsa, rasmni ko'rsatamiz
    // Local file path yoki network URL bo'lishi mumkin
    if (widget.inverter.imageUrl.startsWith('http')) {
      // Network image
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Image.network(
          widget.inverter.imageUrl,
          height: 250,
          width: double.infinity,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              color: Colors.orange[100],
              child: const Icon(
                Icons.electrical_services,
                size: 80,
                color: Colors.orange,
              ),
            );
          },
        ),
      );
    } else {
      // Local asset image
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Image.asset(
          widget.inverter.imageUrl,
          height: 250,
          width: double.infinity,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              color: Colors.orange[100],
              child: const Icon(
                Icons.electrical_services,
                size: 80,
                color: Colors.orange,
              ),
            );
          },
        ),
      );
    }
  }
}
