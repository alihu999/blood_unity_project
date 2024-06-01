import 'package:blood_unity/core/constant/app_routes.dart';
import 'package:blood_unity/core/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../data/model/notification_model.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  MyServices myServices = Get.find();

  Future<void> initialNotifications() async {
    await _firebaseMessaging.requestPermission();
    String? fCMToken = await _firebaseMessaging.getToken();
    print("Token $fCMToken");
    inipushNotifications();
  }

  Future<void> handelMessage(RemoteMessage? message) async {
    if (message == null) return;

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Get.offAllNamed(AppRoutes.homePage);
    } else {
      Get.offAllNamed(AppRoutes.selectLanguge);
    }

    try {
      myServices.getNotifications().add(NotificationModel(
          title: message.notification?.title,
          text: message.notification?.body,
          reciveTime: message.sentTime!));
    } catch (e) {
      print(e);
    }
  }

  inipushNotifications() {
    //Foreground messages

    FirebaseMessaging.instance.getInitialMessage().then((handelMessage));

    FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
  }
}
