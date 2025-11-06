import 'package:flutter/material.dart';
import '../models/inverter_model.dart';
import '../widgets/inverter_card.dart';
import 'order_screen.dart';

class InvertersScreen extends StatefulWidget {
  const InvertersScreen({Key? key}) : super(key: key);

  @override
  _InvertersScreenState createState() => _InvertersScreenState();
}

class _InvertersScreenState extends State<InvertersScreen> {
  List<Inverter> _inverters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInverters();
  }

  void _loadInverters() {
    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _inverters = InverterData.getInverters();
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _loadInverters(),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _inverters.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Inverterlar',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade900,
                            ),
                          ),
                          IconButton(
                            onPressed: _loadInverters,
                            icon: Icon(Icons.refresh,
                                color: Colors.orange.shade900),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Quyosh paneli tizimi uchun yuqori sifatli inverterlar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }
                final inverter = _inverters[index - 1];
                return InverterCard(
                  inverter: inverter,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderScreen(
                          preSelectedInverter: inverter.name,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
