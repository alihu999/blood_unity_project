import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Auth/signup_page_controller.dart';

import '../../../core/share/background.dart';
import 'widget/container_inf.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;

    Get.put(SignUpPageControllerImp());
    return Scaffold(
      body: Stack(
        children: [
          Background(
            title: "Sign Up".tr,
            text: "Please Sign Up to continue".tr,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: hight * 0.25,
                ),
                const ContainerInfo(),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
