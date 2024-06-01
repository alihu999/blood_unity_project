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
  TextEditingController firstName = TextEditingController();
  late GlobalKey<FormState> firstNameFormState;

  TextEditingController lastName = TextEditingController();
  late GlobalKey<FormState> lastNameFormState;
  late FocusNode lastNameFocusNode;

  TextEditingController phone = TextEditingController();
  late GlobalKey<FormState> phoneFormState;
  late FocusNode phoneFocusNode;

  TextEditingController status = TextEditingController();
  late GlobalKey<FormState> statusFormState;
  late FocusNode statusFocusNode;

  TextEditingController numberUnits = TextEditingController();
  late GlobalKey<FormState> numberUnitsFormState;
  late FocusNode numberUnitsFocusNode;

  String governorate = "Damascus";
  late GlobalKey<FormState> governorateFormState;
  late FocusNode governorateFocusNode;

  Set<String> bloodtypeP = {""};
  Set<String> bloodtypeN = {""};
  bool isLoading = false;
  String? docId;

  var userid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore storeInstance = FirebaseFirestore.instance;

  @override
  void onInit() {
    initialValue();

    firstNameFormState = GlobalKey<FormState>();

    lastNameFormState = GlobalKey<FormState>();
    lastNameFocusNode = FocusNode();

    phoneFormState = GlobalKey<FormState>();
    phoneFocusNode = FocusNode();

    statusFormState = GlobalKey<FormState>();
    statusFocusNode = FocusNode();

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
    if (checkForm()) {
      if (bloodtype.isNotEmpty) {
        if (await checkConnection()) {
          try {
            if (docId == null) {
              await storeInstance.collection("obtain_order").doc().set({
                "name": "${firstName.text.trim()} ${lastName.text.trim()}",
                "phone": phone.text.trim(),
                "Health status": status.text.trim(),
                "governorate": governorate,
                "bloodtyp": bloodtype,
                "number of Units": numberUnits.text.trim(),
                "uid": userid,
                "status": "new",
                "date": DateTime.now()
              });
            } else {
              await storeInstance.collection("obtain_order").doc(docId).update({
                "name": "${firstName.text.trim()} ${lastName.text.trim()}",
                "phone": phone.text.trim(),
                "Health status": status.text.trim(),
                "governorate": governorate,
                "bloodtyp": bloodtype,
                "number of Units": numberUnits.text.trim(),
                "uid": userid,
                "status": "new",
                "date": DateTime.now()
              });
              Get.back();
            }
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

  void initialValue() {
    final Map arguments = Get.arguments;
    if (arguments.isNotEmpty) {
      firstName.text = arguments["firstName"];
      lastName.text = arguments["lastName"];
      phone.text = arguments["phone"];
      status.text = arguments["status"];
      numberUnits.text = arguments["numberUnits"];
      bloodtypeN = arguments["bloodtypeN"];
      bloodtypeP = arguments["bloodtypeP"];
      governorate = arguments["governorate"];
      docId = arguments["id"];
    }
  }
}
