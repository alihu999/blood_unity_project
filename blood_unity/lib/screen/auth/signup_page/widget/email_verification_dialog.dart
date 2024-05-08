import 'package:blood_unity/controller/Auth/signup_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerification extends GetView<SignUpPageControllerImp> {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "We will send an account verification link to your email ".tr +
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
                  onPressed: () {
                    controller.creatAccount();
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
