import 'package:flutter/material.dart';
import '../services/cache_service.dart';

class AdminStatsScreen extends StatefulWidget {
  const AdminStatsScreen({Key? key}) : super(key: key);

  @override
  _AdminStatsScreenState createState() => _AdminStatsScreenState();
}

class _AdminStatsScreenState extends State<AdminStatsScreen> {
  List<String> _usageStats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => _isLoading = true);

    final stats = await CacheService.getUsageStats();

    setState(() {
      _usageStats = stats;
      _isLoading = false;
    });
  }

  Map<String, int> _getActionCounts() {
    final actionCounts = <String, int>{};

    for (final stat in _usageStats) {
      final parts = stat.split(':');
      if (parts.length >= 2) {
        final action = parts[1];
        actionCounts[action] = (actionCounts[action] ?? 0) + 1;
      }
    }

    return actionCounts;
  }

  List<String> _getTodayStats() {
    final today = DateTime.now();
    final todayStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    return _usageStats.where((stat) => stat.startsWith(todayStr)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final actionCounts = _getActionCounts();
    final todayStats = _getTodayStats();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistika va hisobotlar'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _loadStats,
            icon: const Icon(Icons.refresh),
            tooltip: 'Yangilash',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Umumiy statistika
                  _buildSectionTitle('Umumiy statistika'),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Jami harakatlar',
                          _usageStats.length.toString(),
                          Icons.analytics,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Bugungi harakatlar',
                          todayStats.length.toString(),
                          Icons.today,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Turli harakatlar',
                          actionCounts.length.toString(),
                          Icons.category,
                          Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Eng ko\'p harakat',
                          actionCounts.isNotEmpty
                              ? actionCounts.entries
                                  .reduce((a, b) => a.value > b.value ? a : b)
                                  .value
                                  .toString()
                              : '0',
                          Icons.trending_up,
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Harakat turlari
                  _buildSectionTitle('Harakat turlari'),
                  const SizedBox(height: 16),

                  if (actionCounts.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(Icons.bar_chart, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Hech qanday statistika yo\'q',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...actionCounts.entries
                        .map(
                          (entry) => Container(
                            margin: const EdgeInsets.only(bottom: 12),
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
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    _getActionIcon(entry.key),
                                    color: Colors.blue[700],
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getActionName(entry.key),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${entry.value} marta',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    entry.value.toString(),
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),

                  const SizedBox(height: 32),

                  // Oxirgi harakatlar
                  _buildSectionTitle('Oxirgi harakatlar'),
                  const SizedBox(height: 16),

                  if (_usageStats.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(Icons.history, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Hech qanday harakat yo\'q',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._usageStats.reversed.take(10).map((stat) {
                      final parts = stat.split(':');
                      if (parts.length >= 2) {
                        final timestamp = parts[0];
                        final action = parts[1];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getActionIcon(action),
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _getActionName(action),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Text(
                                _formatTimestamp(timestamp),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }).toList(),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildStatCard(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getActionIcon(String action) {
    switch (action.toLowerCase()) {
      case 'panel_viewed':
        return Icons.solar_power;
      case 'pricing_viewed':
        return Icons.price_change;
      case 'contact_viewed':
        return Icons.contact_phone;
      case 'app_opened':
        return Icons.open_in_new;
      default:
        return Icons.analytics;
    }
  }

  String _getActionName(String action) {
    switch (action.toLowerCase()) {
      case 'panel_viewed':
        return 'Panel ko\'rildi';
      case 'pricing_viewed':
        return 'Narxlar ko\'rildi';
      case 'contact_viewed':
        return 'Aloqa ko\'rildi';
      case 'app_opened':
        return 'Ilova ochildi';
      default:
        return action;
    }
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return 'Hozir';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes} daqiqa oldin';
      } else if (difference.inDays < 1) {
        return '${difference.inHours} soat oldin';
      } else {
        return '${difference.inDays} kun oldin';
      }
    } catch (e) {
      return timestamp;
    }
  }
}
