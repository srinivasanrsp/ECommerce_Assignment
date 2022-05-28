import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}

  final NotificationDetails _platformChannelSpecifics =
      const NotificationDetails(
          android: AndroidNotificationDetails("product_channel", "Products",
              channelDescription: "description",
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker'));

  void showNotification(int quantity, String productName) async {
    await flutterLocalNotificationsPlugin.show(12345, "ECommerce",
        "Only $quantity $productName available now", _platformChannelSpecifics,
        payload: 'data');
  }
}
