import 'package:blood_unity/core/api/firebase_api.dart';
import 'package:blood_unity/firebase_options.dart';
import 'package:blood_unity/locale/local.dart';
import 'package:blood_unity/locale/locale_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/services/services.dart';
import 'data/model/notification_model.dart';
import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initialServices();
  await FirebaseApi().initialNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyLocalController controllerLang = Get.put(MyLocalController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: controllerLang.language,
      translations: MyTranslations(),
      theme: ThemeData(
        iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
                foregroundColor: Colors.white, iconSize: 30)),
        dialogBackgroundColor: Colors.white,
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
        dialogTheme: const DialogTheme(backgroundColor: Colors.white),
        useMaterial3: true,
      ),
      getPages: routes,
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationModelAdapter());
  var box = await Hive.openBox<NotificationModel>("notificationBox");
  box.add(NotificationModel(
      title: message.notification?.title,
      text: message.notification?.body,
      reciveTime: message.sentTime!));
}
