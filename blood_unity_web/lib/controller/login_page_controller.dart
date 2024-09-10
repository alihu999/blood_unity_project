import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginPageController extends GetxController {
  login();
}

class LoginPageControllerImp extends LoginPageController {
  late TextEditingController email;
  late GlobalKey<FormState> emailFormState;

  late TextEditingController password;
  late GlobalKey<FormState> passwordFormState;

  @override
  void onInit() {
    email = TextEditingController();
    emailFormState = GlobalKey<FormState>();

    password = TextEditingController();
    passwordFormState = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  login() {}
}
