import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'social_block_service.dart';

class AlarmService {
  static const int alarmId = 999;

  static Future<void> schedulePrayerAlarm(DateTime prayerTime, String prayerName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_prayer', prayerName);
    await prefs.setBool('prayer_mode_active', true);

    await AndroidAlarmManager.oneShotAt(
      prayerTime,
      alarmId,
      alarmCallback,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> alarmCallback() async {
    await SocialBlockService.blockSocialMedia();
    final prefs = await SharedPreferences.getInstance();
    final prayerName = prefs.getString('current_prayer') ?? 'Namaz';
    await _showPersistentNotification(prayerName);
  }

  static Future<void> _showPersistentNotification(String prayerName) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'namaz_alarm_channel',
      'Namaz Alarmı',
      importance: Importance.max,
      priority: Priority.max,
      ongoing: true,
      autoCancel: false,
      sound: RawResourceAndroidNotificationSound('adhan'),
      playSound: true,
    );

    await FlutterLocalNotificationsPlugin().show(
      alarmId,
      '$prayerName Vakti!',
      'Sosyal medya kilitlendi. Namaz tamamlanana kadar alarm devam edecek.',
      const NotificationDetails(android: androidDetails),
    );
  }

  static Future<void> cancelPrayerAlarm() async {
    await AndroidAlarmManager.cancel(alarmId);
    await SocialBlockService.unblockSocialMedia();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('prayer_mode_active', false);
    await FlutterLocalNotificationsPlugin().cancel(alarmId);
  }
}