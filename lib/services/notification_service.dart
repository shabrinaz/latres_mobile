import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showFavoriteNotification(String amiiboName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'amiibo_favorite_channel',
      'Amiibo Favorites Notification',
      channelDescription: 'Notifikasi ketika item ditambahkan ke favorit.',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: const DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.show(
      0, 
      'Favorit Ditambahkan!',
      '${amiiboName} berhasil ditambahkan ke daftar favorit.',
      platformChannelSpecifics,
      payload: 'item_favorited',
    );
  }
}