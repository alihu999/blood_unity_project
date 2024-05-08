import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class DonatingPageController extends GetxController {}

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

  RxString governorate = "".obs;
  late GlobalKey<FormState> governorateFormState;
  late FocusNode governorateFocusNode;

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
}
