import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static const String _lastSessionKey = 'last_session_time';
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
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
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    await _requestPermissions();

    _isInitialized = true;
  }

  static Future<void> _requestPermissions() async {
    final androidImpl = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImpl == null) return;

    final notificationsEnabled =
        await androidImpl.areNotificationsEnabled() ?? false;
    if (!notificationsEnabled) {
      await androidImpl.requestNotificationsPermission();
    }

    final exactAlarmPermission = await androidImpl
        .requestExactAlarmsPermission();
    print('Permissão de alarme exato: $exactAlarmPermission');
  }

  static void _onNotificationTap(NotificationResponse response) {
    print('Notificação clicada: ${response.payload}');
  }

  static Future<void> updateLastSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastSessionKey, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<void> scheduleNextNotification() async {
    await initialize();

    final prefs = await SharedPreferences.getInstance();
    final lastSession = prefs.getInt(_lastSessionKey);

    if (lastSession == null) {
      await _scheduleNotificationWithVariation();
      return;
    }

    final lastSessionTime = DateTime.fromMillisecondsSinceEpoch(lastSession);
    final now = DateTime.now();
    final timeSinceLastSession = now.difference(lastSessionTime);

    if (timeSinceLastSession.inHours >= 4) {
      await _scheduleNotificationWithVariation();
    } else {
      final remainingTime = const Duration(hours: 4) - timeSinceLastSession;
      await _scheduleNotificationAfterDuration(remainingTime);
    }
  }

  static Future<void> _scheduleNotificationWithVariation() async {
    final random = Random();
    final baseMinutes = 4 * 60;
    final variationMinutes = 2 * 60;
    final totalMinutes = baseMinutes + random.nextInt(variationMinutes + 1);

    await _scheduleNotificationAfterDuration(Duration(minutes: totalMinutes));
  }

  static Future<void> _scheduleNotificationAfterDuration(
    Duration duration,
  ) async {
    final now = DateTime.now();
    final scheduledTime = now.add(duration);

    final adjustedTime = _adjustTimeIfNeeded(scheduledTime);

    final tzScheduledTime = tz.TZDateTime(
      tz.local,
      adjustedTime.year,
      adjustedTime.month,
      adjustedTime.day,
      adjustedTime.hour,
      adjustedTime.minute,
      adjustedTime.second,
    );

    const androidDetails = AndroidNotificationDetails(
      'pain_reminder_channel',
      'Lembretes de Dor',
      channelDescription: 'Notificações para lembrar de registrar sua dor',
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final messages = [
      'Como está sua dor hoje? Registre no CuidaDor! 💙',
      'Hora de registrar seu bem-estar no CuidaDor 📊',
      'Não esqueça de registrar sua dor hoje! 🩺',
      'Que tal atualizar seu registro de dor? 💪',
      'Monitore sua saúde: registre sua dor agora! ❤️',
    ];

    final random = Random();
    final message = messages[random.nextInt(messages.length)];

    await _notifications.zonedSchedule(
      0,
      'CuidaDor',
      message,
      tzScheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    print('Notificação agendada para: $adjustedTime');
  }

  static DateTime _adjustTimeIfNeeded(DateTime scheduledTime) {
    final hour = scheduledTime.hour;

    if (hour >= 22) {
      final adjusted = DateTime(
        scheduledTime.year,
        scheduledTime.month,
        scheduledTime.day + 1,
        7,
        0,
      );
      return adjusted;
    }

    if (hour < 7) {
      final adjusted = DateTime(
        scheduledTime.year,
        scheduledTime.month,
        scheduledTime.day,
        7,
        0,
      );
      return adjusted;
    }

    return scheduledTime;
  }

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  static Future<bool> areNotificationsEnabled() async {
    if (!_isInitialized) await initialize();

    final androidImpl = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImpl != null) {
      return await androidImpl.areNotificationsEnabled() ?? false;
    }

    return true;
  }
}
