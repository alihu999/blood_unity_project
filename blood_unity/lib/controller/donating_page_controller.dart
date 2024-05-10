import 'package:blood_unity/core/share/custom_snakbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class DonatingPageController extends GetxController {
  confirmOrder();
  bool checkForm();
  checkConnection();
}

class DonatingPageControllerImp extends DonatingPageController {
  late TextEditingController firstName;
  late GlobalKey<FormState> firstNameFormState;

  late TextEditingController lastName;
  late GlobalKey<FormState> lastNameFormState;
  late FocusNode lastNameFocusNode;

  late TextEditingController phone;
  late GlobalKey<FormState> phoneFormState;
  late FocusNode phoneFocusNode;

  late TextEditingController malady;
  late GlobalKey<FormState> maladyFormState;
  late FocusNode maladyFocusNode;

  String governorate = "";
  late GlobalKey<FormState> governorateFormState;
  late FocusNode governorateFocusNode;

  String bloodtype = "";
  String rh = "";
  bool isLoading = false;

  var userid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore storeInstance = FirebaseFirestore.instance;

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

    malady = TextEditingController();
    maladyFormState = GlobalKey<FormState>();
    maladyFocusNode = FocusNode();

    governorateFormState = GlobalKey<FormState>();
    governorateFocusNode = FocusNode();

    super.onInit();
  }

  @override
  confirmOrder() async {
    isLoading = true;
    update();
    if (checkForm()) {
      if (bloodtype != "" && rh != "") {
        if (await checkConnection()) {
          try {
            await storeInstance.collection("donating_order").doc().set({
              "name": "${firstName.text.trim()} ${lastName.text.trim()}",
              "phone": phone.text.trim(),
              "malady": malady.text.trim(),
              "governorate": governorate,
              "bloodtyp": bloodtype,
              "uid": userid,
              "Rh": rh,
              "status": "new"
            });
            Get.back();
            Get.back();

            successfulSnackBar(
                "The request has been submitted successfully".tr);
          } catch (e) {
            errorSnackBar("$e");
          }
        }
      } else {
        errorSnackBar("Please choose your blood group".tr);
      }
    }
    isLoading = false;
    update();
  }

  @override
  bool checkForm() {
    if (firstNameFormState.currentState!.validate() &&
        lastNameFormState.currentState!.validate() &&
        phoneFormState.currentState!.validate() &&
        maladyFormState.currentState!.validate() &&
        governorateFormState.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  checkConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      return true;
    } else {
      errorSnackBar("Check internet connection".tr);
      return false;
    }
  }
}
