/*
// PubDev main package: https://pub.dev/packages/flutter_local_notifications#periodically-show-a-notification-with-a-specified-interval

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// --------------------------------------------------------------------------------------------------------------------

// Init LocalNotificationsPlugin:

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<bool?> initFlutterLocalNotificationsPlugin() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Tehran"));
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  bool? res = await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  return res;
}

// --------------------------------------------------------------------------------------------------------------------

// Send notification:

Future<void> sendNotificationNow({required int id, required String title, required String body}) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(id.toString(), 'channel$id', channelDescription: 'this is channel$id', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(id, title, body, platformChannelSpecifics, payload: 'payload$id');
}

Future<void> sendNotificationWithGregorianDateScheduling({required int id, required String title, required String body, required int year, required int month, required int day, int hour = 0, int minute = 0}) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(id.toString(), 'channel$id', channelDescription: 'this is channel$id', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime(tz.local, year, month, day, hour, minute),
    NotificationDetails(android: androidPlatformChannelSpecifics),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  );
}

Future<void> sendNotificationWithJalaliDateScheduling({required int id, required String title, required String body, required int year, required int month, required int day, int hour = 0, int minute = 0}) async {
  Gregorian convertedDate = Jalali(year, month, day).toGregorian();
  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(id.toString(), 'channel$id', channelDescription: 'this is channel$id', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime(tz.local, convertedDate.year, convertedDate.month, convertedDate.day, hour, minute),
    NotificationDetails(android: androidPlatformChannelSpecifics),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  );
}

Future<void> sendNotificationWithDurationScheduling({required int id, required String title, required String body, required Duration durationLater}) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(id.toString(), 'channel$id', channelDescription: 'this is channel$id', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.now(tz.local).add(durationLater),
    NotificationDetails(android: androidPlatformChannelSpecifics),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  );
}

// --------------------------------------------------------------------------------------------------------------------

// Cancelling/deleting notifications:

Future<void> cancelNotificationWithID({required int id}) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}

Future<void> cancelAllNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

// --------------------------------------------------------------------------------------------------------------------
*/
