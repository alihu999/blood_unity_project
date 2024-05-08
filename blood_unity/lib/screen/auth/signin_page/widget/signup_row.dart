import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Auth/signin_page_controller.dart';

class SignUpRow extends GetView<SignInControllerImp> {
  const SignUpRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      width: 370,
      child: Row(
        children: [
          Text(
            "Don't have account?".tr,
            style: const TextStyle(fontSize: 15),
          ),
          TextButton(
              onPressed: () {
                controller.goToSignUp();
              },
              child: Text(
                "Sign Up".tr,
                style: const TextStyle(fontSize: 15),
              )),
        ],
      ),
    );
  }
}
