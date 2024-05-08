import 'package:blood_unity/core/constant/app_color.dart';
import 'package:blood_unity/core/constant/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../locale/locale_controller.dart';

class SelectLanguge extends StatelessWidget {
  const SelectLanguge({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocalController controllerLang = Get.find();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.selectLangauge,
              width: width > 400 ? 200 : width * 0.49,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "selectLan".tr,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(85, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor),
                    onPressed: () {
                      controllerLang.changeLanguge("ar");
                    },
                    child: const Text(
                      "AR",
                      style: TextStyle(fontSize: 20),
                    )),
                const SizedBox(
                  width: 50,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(85, 50),
                      side: BorderSide(color: AppColors.primaryColor),
                      foregroundColor: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      controllerLang.changeLanguge("en");
                    },
                    child: const Text(
                      "EN",
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: GetBuilder<MyLocalController>(builder: (controller) {
                if (controller.lodaing) {
                  return const CircularProgressIndicator();
                } else {
                  return const SizedBox(
                    height: 0,
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
