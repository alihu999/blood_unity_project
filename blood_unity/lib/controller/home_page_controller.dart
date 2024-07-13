import 'package:blood_unity/core/constant/app_routes.dart';
import 'package:blood_unity/core/share/wait_message.dart';
import 'package:blood_unity/screen/home_page/widget/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/services.dart';
import '../core/share/custom_snakbar.dart';
import '../data/model/notification_model.dart';

abstract class HomePageController extends GetxController {
  Future getNews();
  Future getArticle();
  signOut();
  openNotificationDialog();
  getNewnotification();
}

class HomePageControllerImp extends HomePageController {
  MyServices myServices = Get.find();
  String? sharedPrefLang;

  FirebaseFirestore storeInstance = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser!;

  RxList notifications = [].obs;
  RxList newNotificatios = [].obs;

  @override
  void onInit() {
    sharedPrefLang = myServices.sharedPreferences.getString("lang");
    notifications.value = myServices.getNotifications().values.toList();

    getNewnotification();

    foreGroundNotification();
    super.onInit();
  }

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> getNews() async {
    try {
      QuerySnapshot<Map<String, dynamic>> respons =
          await storeInstance.collection('news').get();
      return respons.docs;
    } catch (e) {
      errorSnackBar("$e");
      return null;
    }
  }

  @override
  signOut() async {
    waitMassege();
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.signIn);
  }

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      getArticle() async {
    try {
      QuerySnapshot<Map<String, dynamic>> respons =
          await storeInstance.collection('article').get();
      return respons.docs;
    } catch (e) {
      errorSnackBar("$e");
      return null;
    }
  }

  foreGroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      myServices.getNotifications().add(NotificationModel(
          title: message.notification?.title,
          text: message.notification?.body,
          reciveTime: message.sentTime!));
      getNewnotification();
    });
  }

  @override
  openNotificationDialog() {
    List<NotificationModel> deleteNotificatios = myServices
        .getNotifications()
        .values
        .where((element) => element.title == null || element.text == null)
        .toList();
    for (NotificationModel noti in deleteNotificatios) {
      noti.delete();
    }
    notifications.value =
        myServices.getNotifications().values.toList().reversed.toList();
    Get.defaultDialog(
        onWillPop: () {
          for (NotificationModel noti in newNotificatios) {
            noti.status = "read";
            noti.save();
          }
          getNewnotification();
          return Future(() => true);
        },
        contentPadding: const EdgeInsets.only(right: 0, left: 0),
        title: "Notifications".tr,
        content: const NotificationDialog());
  }

  @override
  getNewnotification() {
    newNotificatios.value = myServices
        .getNotifications()
        .values
        .where((element) => element.status == "new")
        .toList();
  }
}
