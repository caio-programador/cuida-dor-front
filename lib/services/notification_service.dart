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

  // Inicializa o serviço de notificações
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

    // Solicita permissões no Android 13+
    await _requestPermissions();

    _isInitialized = true;
  }

  static Future<void> _requestPermissions() async {
    if (await _notifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.areNotificationsEnabled() ??
        false) {
      return;
    }

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  static void _onNotificationTap(NotificationResponse response) {
    // Aqui você pode navegar para uma tela específica quando clicar na notificação
    print('Notificação clicada: ${response.payload}');
  }

  // Registra o horário da última sessão do usuário
  static Future<void> updateLastSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastSessionKey, DateTime.now().millisecondsSinceEpoch);
  }

  // Agenda notificação após 4 horas (com variação) da última sessão
  static Future<void> scheduleNextNotification() async {
    await initialize();

    final prefs = await SharedPreferences.getInstance();
    final lastSession = prefs.getInt(_lastSessionKey);

    if (lastSession == null) {
      // Se não há sessão anterior, agenda para daqui a 4-6 horas
      await _scheduleNotificationWithVariation();
      return;
    }

    final lastSessionTime = DateTime.fromMillisecondsSinceEpoch(lastSession);
    final now = DateTime.now();
    final timeSinceLastSession = now.difference(lastSessionTime);

    // Se passou mais de 4 horas, agenda uma notificação
    if (timeSinceLastSession.inHours >= 4) {
      await _scheduleNotificationWithVariation();
    } else {
      // Calcula quanto tempo falta para 4 horas
      final remainingTime = const Duration(hours: 4) - timeSinceLastSession;
      await _scheduleNotificationAfterDuration(remainingTime);
    }
  }

  // Agenda notificação com variação de tempo (4 a 6 horas)
  static Future<void> _scheduleNotificationWithVariation() async {
    final random = Random();
    // Variação entre 4 e 6 horas (em minutos)
    final baseMinutes = 4 * 60; // 4 horas
    final variationMinutes = 2 * 60; // 2 horas de variação
    final totalMinutes = baseMinutes + random.nextInt(variationMinutes + 1);

    await _scheduleNotificationAfterDuration(Duration(minutes: totalMinutes));
  }

  // Agenda notificação após uma duração específica
  static Future<void> _scheduleNotificationAfterDuration(
    Duration duration,
  ) async {
    final scheduledTime = DateTime.now().add(duration);

    // Verifica se o horário agendado está entre 22h e 7h
    final adjustedTime = _adjustTimeIfNeeded(scheduledTime);

    // Converte para TZDateTime usando o timezone local configurado
    final tzScheduledTime = tz.TZDateTime.from(adjustedTime, tz.local);

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
      0, // ID da notificação
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

  // Ajusta o horário se estiver entre 22h e 7h
  static DateTime _adjustTimeIfNeeded(DateTime scheduledTime) {
    final hour = scheduledTime.hour;

    // Se está entre 22h (22) e 23h59 (23)
    if (hour >= 23) {
      // Agenda para 7h do dia seguinte
      return DateTime(
        scheduledTime.year,
        scheduledTime.month,
        scheduledTime.day + 1,
        7,
        0,
      );
    }

    // Se está entre 0h (0) e 6h59 (6)
    if (hour < 7) {
      // Agenda para 7h do mesmo dia
      return DateTime(
        scheduledTime.year,
        scheduledTime.month,
        scheduledTime.day,
        7,
        0,
      );
    }

    // Horário está ok (entre 7h e 21h59)
    return scheduledTime;
  }

  // Cancela todas as notificações
  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Cancela uma notificação específica
  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  // Verifica se as notificações estão habilitadas
  static Future<bool> areNotificationsEnabled() async {
    if (!_isInitialized) await initialize();

    final androidImpl = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImpl != null) {
      return await androidImpl.areNotificationsEnabled() ?? false;
    }

    return true; // iOS geralmente permite por padrão após permissão
  }
}
