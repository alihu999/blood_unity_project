import 'package:blood_unity/core/share/custom_snakbar.dart';
import 'package:blood_unity/core/share/wait_message.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../core/constant/app_routes.dart';
import '../../screen/auth/signin_page/widget/reset_password_dialog.dart';

abstract class SignInController extends GetxController {
  goToSignUp();
  showHidePassword();
  signIn();
  signInWithGoogle();
  signInWithFacebook();
  sendEmail();
  forgetPassword();
}

class SignInControllerImp extends SignInController {
  late TextEditingController email;
  late GlobalKey<FormState> emailFormState;

  late TextEditingController password;
  late GlobalKey<FormState> passwordFormState;
  late FocusNode passwordFocusNode;
  bool passwordVisible = false;

  bool isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    email = TextEditingController();
    emailFormState = GlobalKey<FormState>();

    password = TextEditingController();
    passwordFormState = GlobalKey<FormState>();
    passwordFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();

    super.dispose();
  }

  @override
  goToSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }

  @override
  showHidePassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  @override
  signIn() async {
    isLoading = true;
    update();
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      if (emailFormState.currentState!.validate() &&
          passwordFormState.currentState!.validate()) {
        try {
          auth.signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());
          Get.offAllNamed(AppRoutes.homePage);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            errorSnackBar("No user found for that email".tr);
          } else if (e.code == 'wrong-password') {
            errorSnackBar('The password is incorrect'.tr);
          }
        }
      }
    } else {
      errorSnackBar("Check internet connection".tr);
    }

    isLoading = false;
    update();
  }

  @override
  signInWithGoogle() async {
    try {
      waitMassege();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.back();
      Get.offAllNamed(AppRoutes.homePage);
    } catch (e) {
      errorSnackBar("$e");
    }
  }

  @override
  signInWithFacebook() async {
    try {
      waitMassege();

      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      Get.back();
      Get.offAllNamed(AppRoutes.homePage);
    } catch (e) {
      print("$e");
      errorSnackBar("$e");
    }
  }

  @override
  sendEmail() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      Get.back();
      waitMassege();
      await auth.sendPasswordResetEmail(email: email.text.trim());
      Get.back();
      successfulSnackBar("the email has been sent");
    } else {
      errorSnackBar("Check internet connection".tr);
    }
  }

  @override
  forgetPassword() {
    if (emailFormState.currentState!.validate()) {
      Get.defaultDialog(
          title: "Reset Password", content: const ResendPassword());
    }
  }
}
