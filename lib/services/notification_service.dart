import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  // Bildirishnomalarni sozlash
  Future<void> initialize() async {
    if (_initialized) return;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _initialized = true;
  }

  // Bildirishnoma bosilganda
  void _onNotificationTapped(NotificationResponse response) {
    print('Bildirishnoma bosildi: ${response.payload}');
    // Bu yerda kerakli sahifaga o'tish logikasini qo'shish mumkin
  }

  // Oddiy bildirishnoma ko'rsatish
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'solar_panel_channel',
      'Quyosh Paneli Xabarlari',
      channelDescription: 'Yangi panellar va yangiliklar haqida xabarlar',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now().millisecond,
      title,
      body,
      details,
      payload: payload,
    );
  }

  // Yangi panel haqida xabar
  Future<void> notifyNewPanel(String panelName) async {
    await showNotification(
      title: '🌞 Yangi Panel!',
      body: '$panelName paneli qo\'shildi. Ko\'rib chiqing!',
      payload: 'new_panel',
    );
  }

  // Yangi yangilik haqida xabar
  Future<void> notifyNewNews(String newsTitle) async {
    await showNotification(
      title: '📰 Yangi Yangilik',
      body: newsTitle,
      payload: 'new_news',
    );
  }

  // Buyurtma holati haqida xabar
  Future<void> notifyOrderStatus(String status) async {
    String message = '';
    switch (status) {
      case 'confirmed':
        message = 'Buyurtmangiz tasdiqlandi!';
        break;
      case 'completed':
        message = 'Buyurtmangiz bajarildi!';
        break;
      case 'cancelled':
        message = 'Buyurtmangiz bekor qilindi.';
        break;
      default:
        message = 'Buyurtma holati yangilandi.';
    }

    await showNotification(
      title: '📦 Buyurtma',
      body: message,
      payload: 'order_status',
    );
  }

  // Bildirishnomalar yoqilganmi tekshirish
  Future<bool> areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? true;
  }

  // Bildirishnomalarni yoqish/o'chirish
  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', enabled);
  }
}
