import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Auth/signin_page_controller.dart';

class ResendPassword extends GetView<SignInControllerImp> {
  const ResendPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "We will send you an email to reset your password".tr +
                controller.email.text.trim(),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 25,
                  ),
                  label: Text(
                    "cancel".tr,
                    style: const TextStyle(color: Colors.red, fontSize: 15),
                  )),
              ElevatedButton.icon(
                  onPressed: () async {
                    controller.sendEmail();
                  },
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 25,
                  ),
                  label: Text(
                    "confirm".tr,
                    style: const TextStyle(color: Colors.green, fontSize: 15),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
