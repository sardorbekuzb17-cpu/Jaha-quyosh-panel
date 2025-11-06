import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _monthlyBillController = TextEditingController();
  final _roofAreaController = TextEditingController();

  double _monthlyBill = 0;
  double _roofArea = 0;
  double _recommendedCapacity = 0;
  double _estimatedCost = 0;
  double _monthlySavings = 0;
  double _paybackPeriod = 0;
  double _co2Reduction = 0;
  bool _showResults = false;

  // Hisob-kitob konstantalari
  static const double _electricityRate = 800; // so'm per kWh
  static const double _solarPanelCostPerWatt = 3000; // so'm per Watt
  static const double _sunHoursPerDay = 5.5; // O'zbekiston uchun o'rtacha
  static const double _systemEfficiency = 0.85;
  static const double _co2PerKwh = 0.5; // kg CO2 per kWh

  void _calculateSolarSystem() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _monthlyBill = double.parse(_monthlyBillController.text);
      _roofArea = double.parse(_roofAreaController.text);

      // Oylik energiya iste'moli (kWh)
      final monthlyConsumption = _monthlyBill / _electricityRate;

      // Kunlik energiya iste'moli
      final dailyConsumption = monthlyConsumption / 30;

      // Tavsiya etilgan tizim quvvati (kW)
      _recommendedCapacity =
          dailyConsumption / (_sunHoursPerDay * _systemEfficiency);

      // Maksimal o'rnatish mumkin bo'lgan quvvat (tom maydoni asosida)
      final maxCapacityByRoof = _roofArea * 0.15; // 150W per m²

      // Haqiqiy tavsiya etilgan quvvat
      _recommendedCapacity = _recommendedCapacity > maxCapacityByRoof
          ? maxCapacityByRoof
          : _recommendedCapacity;

      // Minimum 10kW quvvat
      if (_recommendedCapacity < 10) {
        _recommendedCapacity = 10;
      }

      // Taxminiy narx
      _estimatedCost = _recommendedCapacity * 1000 * _solarPanelCostPerWatt;

      // Oylik tejamkorlik
      final monthlyGeneration =
          _recommendedCapacity * _sunHoursPerDay * 30 * _systemEfficiency;
      _monthlySavings = monthlyGeneration * _electricityRate;

      // Qaytish muddati (yil)
      _paybackPeriod = _estimatedCost / (_monthlySavings * 12);

      // CO2 kamaytirish (kg/yil)
      _co2Reduction = monthlyGeneration * 12 * _co2PerKwh;

      _showResults = true;
    });
  }

  void _resetCalculator() {
    setState(() {
      _monthlyBillController.clear();
      _roofAreaController.clear();
      _showResults = false;
      _monthlyBill = 0;
      _roofArea = 0;
      _recommendedCapacity = 0;
      _estimatedCost = 0;
      _monthlySavings = 0;
      _paybackPeriod = 0;
      _co2Reduction = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quyosh Paneli Kalkulyatori'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _resetCalculator,
            icon: const Icon(Icons.refresh),
            tooltip: 'Tozalash',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kirish ma'lumotlari
              _buildSectionTitle('Ma\'lumotlaringizni kiriting'),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _monthlyBillController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Oylik elektr hisobi (so\'m)',
                        hintText: 'Masalan: 150000',
                        prefixIcon: const Icon(Icons.receipt_long),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixText: 'so\'m',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Oylik elektr hisobini kiriting';
                        }
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'To\'g\'ri miqdor kiriting';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _roofAreaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Tom maydoni (m²)',
                        hintText: 'Masalan: 50',
                        prefixIcon: const Icon(Icons.roofing),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixText: 'm²',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tom maydonini kiriting';
                        }
                        final area = double.tryParse(value);
                        if (area == null || area <= 0) {
                          return 'To\'g\'ri maydon kiriting';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _calculateSolarSystem,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Hisoblash',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (_showResults) ...[
                const SizedBox(height: 32),

                // Natijalar
                _buildSectionTitle('Hisob-kitob natijalari'),
                const SizedBox(height: 16),

                // Asosiy natijalar
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[700]!, Colors.green[500]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.solar_power,
                        size: 48,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Tavsiya etilgan tizim',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_recommendedCapacity.toStringAsFixed(1)} kW',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Batafsil natijalar
                _buildResultCard(
                  'Taxminiy narx',
                  '${(_estimatedCost / 1000000).toStringAsFixed(1)} million so\'m',
                  Icons.attach_money,
                  Colors.blue,
                ),
                const SizedBox(height: 12),

                _buildResultCard(
                  'Oylik tejamkorlik',
                  '${_monthlySavings.toStringAsFixed(0)} so\'m',
                  Icons.savings,
                  Colors.green,
                ),
                const SizedBox(height: 12),

                _buildResultCard(
                  'Qaytish muddati',
                  '${_paybackPeriod.toStringAsFixed(1)} yil',
                  Icons.schedule,
                  Colors.orange,
                ),
                const SizedBox(height: 12),

                _buildResultCard(
                  'Yillik CO₂ kamaytirish',
                  '${_co2Reduction.toStringAsFixed(0)} kg',
                  Icons.eco,
                  Colors.teal,
                ),
                const SizedBox(height: 32),

                // Qo'shimcha ma'lumot
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: Colors.blue[700]),
                          const SizedBox(width: 12),
                          Text(
                            'Muhim ma\'lumotlar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                          'Kunlik quyosh soatlari', '$_sunHoursPerDay soat'),
                      _buildInfoRow('Tizim samaradorligi',
                          '${(_systemEfficiency * 100).toInt()}%'),
                      _buildInfoRow('Elektr narxi',
                          '${_electricityRate.toInt()} so\'m/kWh'),
                      _buildInfoRow('25 yillik tejamkorlik',
                          '${((_monthlySavings * 12 * 25) / 1000000).toStringAsFixed(1)} million so\'m'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Harakat tugmalari
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Biz bilan bog'lanish
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Biz bilan bog\'laning'),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Professional konsultatsiya uchun:'),
                                  SizedBox(height: 12),
                                  Text('📞 +998 93 087 47 58'),
                                  Text('📧 sardorbekuzb17@gmail.com'),
                                  Text('📱 @jahongir_solar'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Yopish'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Bog\'lanish',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _resetCalculator,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Qayta hisoblash'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildResultCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _monthlyBillController.dispose();
    _roofAreaController.dispose();
    super.dispose();
  }
}
