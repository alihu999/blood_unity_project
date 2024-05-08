import 'package:blood_unity/core/constant/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/services.dart';

class MyLocalController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();
  bool lodaing = false;

  changeLanguge(String languagecode) {
    lodaing = true;
    update();
    Locale locale = Locale(languagecode);
    myServices.sharedPreferences.setString("lang", languagecode);
    Get.updateLocale(locale);
    Get.offAllNamed(AppRoutes.signIn);
  }

  @override
  void onInit() {
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
