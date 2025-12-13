import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  static Future<void> init() async {
    // Request permissions
    await _firebaseMessaging.requestPermission();
    // Android settings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (payload) {
        // Optional: handle tap on notification
        debugPrint('Notification tapped with payload: $payload');
      },
    );
    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });
  }
  static Future<void> _showNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'daily_recipe',
      'Daily Recipe',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    await _localNotifications.show(
      0,
      message.notification?.title ?? 'MealDB',
      message.notification?.body ?? 'Check today\'s random recipe!',
      notificationDetails,
    );
  }
}
