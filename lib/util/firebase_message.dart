import 'package:firebase_messaging/firebase_messaging.dart';

void requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Usuário concedeu permissão para notificações.');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('Permissão provisória concedida.');
  } else {
    print('Permissão negada para notificações.');
  }
}
