import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/share/custom_snakbar.dart';

abstract class ObtainPageController extends GetxController {
  confirmOrder();
  bool checkForm();
  checkConnection();
}

class ObtainPageControllerImp extends ObtainPageController {
  late TextEditingController firstName;
  late GlobalKey<FormState> firstNameFormState;

  late TextEditingController lastName;
  late GlobalKey<FormState> lastNameFormState;
  late FocusNode lastNameFocusNode;

  late TextEditingController phone;
  late GlobalKey<FormState> phoneFormState;
  late FocusNode phoneFocusNode;

  late TextEditingController status;
  late GlobalKey<FormState> statusFormState;
  late FocusNode statusFocusNode;

  late TextEditingController numberUnits;
  late GlobalKey<FormState> numberUnitsFormState;
  late FocusNode numberUnitsFocusNode;

  String governorate = "";
  late GlobalKey<FormState> governorateFormState;
  late FocusNode governorateFocusNode;

  Set<String> bloodtypeP = {""};
  Set<String> bloodtypeN = {""};
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

    status = TextEditingController();
    statusFormState = GlobalKey<FormState>();
    statusFocusNode = FocusNode();

    numberUnits = TextEditingController();
    numberUnitsFormState = GlobalKey<FormState>();
    numberUnitsFocusNode = FocusNode();

    governorateFormState = GlobalKey<FormState>();
    governorateFocusNode = FocusNode();

    super.onInit();
  }

  @override
  confirmOrder() async {
    Set<String> bloodtype = bloodtypeN.union(bloodtypeP);
    bloodtype.remove("");

    isLoading = true;
    update();
    print(bloodtype);
    if (checkForm()) {
      if (bloodtype.isNotEmpty) {
        if (await checkConnection()) {
          try {
            await storeInstance.collection("obtain_order").doc().set({
              "name": "${firstName.text.trim()} ${lastName.text.trim()}",
              "phone": phone.text.trim(),
              "Health status": status.text.trim(),
              "governorate": governorate,
              "bloodtyp": bloodtype,
              "number of Units": numberUnits.text.trim(),
              "uid": userid,
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
        statusFormState.currentState!.validate() &&
        numberUnitsFormState.currentState!.validate() &&
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
