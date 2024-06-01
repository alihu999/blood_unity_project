import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/model/notification_model.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  Future<MyServices> init() async {
    await initHiveBox();
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  initHiveBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NotificationModelAdapter());
    await Hive.openBox<NotificationModel>("notificationBox");
  }

  Box<NotificationModel> getNotifications() =>
      Hive.box<NotificationModel>("notificationBox");
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
