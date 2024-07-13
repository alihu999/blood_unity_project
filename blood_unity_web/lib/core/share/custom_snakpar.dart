import 'package:get/get.dart';
import 'package:flutter/material.dart';

errorSnackBar(String message) {
  return Get.snackbar("Error".tr, message,
      maxWidth: 400,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      icon: const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 40,
      ),
      backgroundColor: Colors.black.withOpacity(0.5));
}

successfulSnackBar(String message) {
  return Get.snackbar("Done", message,
      maxWidth: 400,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      icon: const Icon(
        Icons.task_alt_outlined,
        color: Colors.green,
        size: 40,
      ),
      backgroundColor: Colors.black.withOpacity(0.5));
}
