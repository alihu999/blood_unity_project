import 'package:blood_unity/core/constant/app_color.dart';
import 'package:blood_unity/firebase_options.dart';
import 'package:blood_unity/locale/local.dart';
import 'package:blood_unity/locale/locale_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/services/services.dart';
import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initialServices();
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
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        dialogTheme: const DialogTheme(backgroundColor: Colors.white),
        useMaterial3: true,
      ),
      getPages: routes,
    );
  }
}
