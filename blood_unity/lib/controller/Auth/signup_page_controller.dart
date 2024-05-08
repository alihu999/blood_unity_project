import 'package:blood_unity/core/constant/app_routes.dart';
import 'package:blood_unity/core/share/custom_snakbar.dart';
import 'package:blood_unity/core/share/wait_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../screen/auth/signup_page/widget/email_verification_dialog.dart';

abstract class SignUpPageController extends GetxController {
  showHidePassword();
  showHideConfirmPassword();
  signUp();
  Future<bool> checkPhoneEmailNotExist();
  bool checkForm();
  creatAccount();
}

class SignUpPageControllerImp extends SignUpPageController {
  late TextEditingController firstName;
  late GlobalKey<FormState> firstNameFormState;

  late TextEditingController lastName;
  late GlobalKey<FormState> lastNameFormState;
  late FocusNode lastNameFocusNode;

  late TextEditingController email;
  late GlobalKey<FormState> emailFormState;
  late FocusNode emailFocusNode;

  late TextEditingController phone;
  late GlobalKey<FormState> phoneFormState;
  late FocusNode phoneFocusNode;

  late TextEditingController password;
  late GlobalKey<FormState> passwordFormState;
  late FocusNode passwordFocusNode;
  bool passwordVisible = false;

  late TextEditingController confirmPassword;
  late GlobalKey<FormState> confirmPasswordFormState;
  late FocusNode confirmPasswordFocusNode;
  bool confirmPasswordVisible = false;

  bool isLodaing = false;

  FirebaseFirestore storeInstance = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  String smsCode = "";
  String uiCode = "";

  @override
  void onInit() {
    firstName = TextEditingController();
    firstNameFormState = GlobalKey<FormState>();

    lastName = TextEditingController();
    lastNameFormState = GlobalKey<FormState>();
    lastNameFocusNode = FocusNode();

    phone = TextEditingController();
    phoneFormState = GlobalKey<FormState>();
    phoneFocusNode = FocusNode();

    email = TextEditingController();
    emailFormState = GlobalKey<FormState>();
    emailFocusNode = FocusNode();

    password = TextEditingController();
    passwordFormState = GlobalKey<FormState>();
    passwordFocusNode = FocusNode();

    confirmPassword = TextEditingController();
    confirmPasswordFormState = GlobalKey<FormState>();
    confirmPasswordFocusNode = FocusNode();
    super.onInit();
  }

  @override
  showHideConfirmPassword() {
    confirmPasswordVisible = !confirmPasswordVisible;
    update();
  }

  @override
  showHidePassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  @override
  signUp() async {
    isLodaing = true;
    update();
    if (checkForm()) {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (!connectivityResult.contains(ConnectivityResult.none)) {
        if (await checkPhoneEmailNotExist()) {
          Get.defaultDialog(
              title: "email verify".tr, content: const EmailVerification());
        }
      } else {
        errorSnackBar("Check internet connection".tr);
      }
    }
    isLodaing = false;
    update();
  }

  @override
  Future<bool> checkPhoneEmailNotExist() async {
    var resphone = await storeInstance
        .collection('user')
        .where("phone", isEqualTo: phone.text.trim())
        .get();
    var resEmail = await storeInstance
        .collection('user')
        .where("email", isEqualTo: email.text.trim())
        .get();
    if (resphone.docs.isNotEmpty) {
      errorSnackBar("The phone number is used by another user".tr);
      return false;
    } else if (resEmail.docs.isNotEmpty) {
      errorSnackBar("The Email is used by another user".tr);
      return false;
    } else {
      return true;
    }
  }

  @override
  bool checkForm() {
    if (firstNameFormState.currentState!.validate() &&
        lastNameFormState.currentState!.validate() &&
        phoneFormState.currentState!.validate() &&
        emailFormState.currentState!.validate() &&
        passwordFormState.currentState!.validate() &&
        confirmPasswordFormState.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  creatAccount() async {
    Get.back();
    waitMassege();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());
      await storeInstance.collection('user').doc().set({
        "email": email.text.trim(),
        "name": "${firstName.text.trim()} ${lastName.text.trim()}",
        "phone": phone.text.trim()
      });

      if (userCredential.user != null) {
        await userCredential.user!.sendEmailVerification();
        await userCredential.user!.updateDisplayName(
            "${firstName.text.trim()} ${lastName.text.trim()}");
        Get.offAllNamed(AppRoutes.homePage);
      }
    } catch (e) {
      errorSnackBar("$e");
      // errorSnackBar("Account creation failed, try again".tr);
    }
  }
}
