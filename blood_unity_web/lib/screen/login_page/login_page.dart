import 'package:blood_unity_web/core/constant/app_colors.dart';
import 'package:blood_unity_web/core/share/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_page_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageControllerImp controller = Get.put(LoginPageControllerImp());
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/splash.png",
                height: 200,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFiled(
                  lable: "Email",
                  filedColors: AppColors.primaryColor,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "The email field cannot be empty".tr;
                    } else if (!GetUtils.isEmail(val)) {
                      return "Not Valid Email".tr;
                    } else {
                      return null;
                    }
                  },
                  textController: controller.email,
                  formState: controller.emailFormState,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(
                height: 30,
              ),
              CustomTextFiled(
                  lable: "password",
                  filedColors: AppColors.primaryColor,
                  validator: (val) {
                    return null;
                  },
                  textController: controller.password,
                  formState: controller.passwordFormState,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(110, 40),
                    backgroundColor: AppColors.primaryColor),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
