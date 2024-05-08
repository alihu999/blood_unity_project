import 'package:get/get.dart';

nameValidation(String name) {
  if (name.length < 3) {
    return "The name cannot be less than 3 letters".tr;
  } else if (name.length > 10) {
    return "The name cannot be more than 10 letters".tr;
  } else {
    return null;
  }
}

phoneValidation(String phone) {
  if (phone.length != 10) {
    return "The phone number must be 10 digits".tr;
  } else if (!GetUtils.isPhoneNumber(phone)) {
    return "The phone number not valid".tr;
  } else {
    return null;
  }
}

passwordValidation(String password) {
  if (password.length < 4) {
    return "The password cannot be less than 4 letters".tr;
  } else if (password.length > 10) {
    return "The password cannot be more than 10 letters".tr;
  } else {
    return null;
  }
}

emailValidation(String email) {
  if (email.isEmpty) {
    return "The email field cannot be empty".tr;
  } else if (!GetUtils.isEmail(email)) {
    return "Not Valid Email".tr;
  } else {
    return null;
  }
}
