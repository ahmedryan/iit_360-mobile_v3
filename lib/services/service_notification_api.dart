import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServiceApi {
  static FlutterLocalNotificationsPlugin initialize() {
    var _flnp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettings = InitializationSettings(android: android);
    _flnp.initialize(initSettings);
    return _flnp;
  }

  static Future showNotification(var title, var subtitle, var payload,
      FlutterLocalNotificationsPlugin flnp) async {
    var android = AndroidNotificationDetails(
      'channelIdSimple',
      'channelNameSimple',
      'channelDescriptionSimple',
      priority: Priority.high,
      importance: Importance.max,
    );
    var platform = NotificationDetails(android: android);
    await flnp.show(1, title, subtitle, platform, payload: payload);
  }

  static Future showScheduledNotification(
      {var id = 0,
      var title,
      var body,
      var payload,
      required var scheduledDate,
      var flnp}) async {
    var android = AndroidNotificationDetails(
      'channelIdScheduled',
      'channelNameScheduled',
      'channelDescriptionScheduled',
      sound: RawResourceAndroidNotificationSound('alarm_music'),
      playSound: true,
      priority: Priority.high,
      importance: Importance.max,
    );
    var platform = NotificationDetails(android: android);
    tz.initializeTimeZones();
    await flnp.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platform,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  static Future cancelAllNotifications() async {
    var _flnp = FlutterLocalNotificationsPlugin();
    await _flnp.cancelAll();
  }
}
