import 'package:blood_unity/core/share/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Auth/signup_page_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/share/custome_textfield.dart';

class ContainerInfo extends GetView<SignUpPageControllerImp> {
  const ContainerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: hight * 0.65,
      width: width * 0.9,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 20, left: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(-5, 5), blurRadius: 10)
          ],
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextFiled(
            isPassword: false,
            lable: "First Name".tr,
            filedColors: AppColors.primaryColor,
            suffixicon: const Icon(Icons.person),
            validator: (val) {
              return nameValidation(val!);
            },
            textController: controller.firstName,
            formState: controller.firstNameFormState,
            keyboardType: TextInputType.name,
            onFieldSubmitted: (val) {
              if (controller.firstNameFormState.currentState!.validate()) {
                FocusScope.of(context)
                    .requestFocus(controller.lastNameFocusNode);
              }
            },
          ),
          CustomTextFiled(
            isPassword: false,
            lable: "Last Name".tr,
            filedColors: AppColors.primaryColor,
            suffixicon: const Icon(Icons.person),
            validator: (val) {
              return nameValidation(val!);
            },
            textController: controller.lastName,
            formState: controller.lastNameFormState,
            focusNode: controller.lastNameFocusNode,
            keyboardType: TextInputType.name,
            onFieldSubmitted: (val) {
              if (controller.lastNameFormState.currentState!.validate()) {
                FocusScope.of(context).requestFocus(controller.phoneFocusNode);
              }
            },
          ),
          CustomTextFiled(
            isPassword: false,
            lable: "Phone".tr,
            filedColors: AppColors.primaryColor,
            suffixicon: const Icon(Icons.phone),
            validator: (val) {
              return phoneValidation(val!);
            },
            textController: controller.phone,
            formState: controller.phoneFormState,
            focusNode: controller.phoneFocusNode,
            keyboardType: TextInputType.phone,
            onFieldSubmitted: (val) {
              if (controller.phoneFormState.currentState!.validate()) {
                FocusScope.of(context).requestFocus(controller.emailFocusNode);
              }
            },
          ),
          CustomTextFiled(
            isPassword: false,
            lable: "Email".tr,
            filedColors: AppColors.primaryColor,
            suffixicon: const Icon(Icons.email),
            validator: (val) {
              return emailValidation(val!);
            },
            textController: controller.email,
            formState: controller.emailFormState,
            focusNode: controller.emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (val) {
              if (controller.emailFormState.currentState!.validate()) {
                FocusScope.of(context)
                    .requestFocus(controller.passwordFocusNode);
              }
            },
          ),
          GetBuilder<SignUpPageControllerImp>(builder: (controller) {
            return CustomTextFiled(
              isPassword: !controller.passwordVisible,
              lable: "Password".tr,
              filedColors: AppColors.primaryColor,
              suffixicon: IconButton(
                  onPressed: () {
                    controller.showHidePassword();
                  },
                  icon: Icon(controller.passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off)),
              validator: (val) {
                return passwordValidation(val!);
              },
              textController: controller.password,
              formState: controller.passwordFormState,
              focusNode: controller.passwordFocusNode,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (val) {
                if (controller.passwordFormState.currentState!.validate()) {
                  FocusScope.of(context)
                      .requestFocus(controller.confirmPasswordFocusNode);
                }
              },
            );
          }),
          GetBuilder<SignUpPageControllerImp>(builder: (controller) {
            return CustomTextFiled(
              isPassword: !controller.confirmPasswordVisible,
              lable: "confirm password".tr,
              filedColors: AppColors.primaryColor,
              suffixicon: IconButton(
                  onPressed: () {
                    controller.showHideConfirmPassword();
                  },
                  icon: Icon(controller.confirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off)),
              validator: (val) {
                if (val!.trim() != controller.password.text.trim()) {
                  return "Password mismatch".tr;
                } else {
                  return null;
                }
              },
              textController: controller.confirmPassword,
              formState: controller.confirmPasswordFormState,
              focusNode: controller.confirmPasswordFocusNode,
              keyboardType: TextInputType.name,
              onFieldSubmitted: (val) {
                controller.confirmPasswordFormState.currentState!.validate();
              },
            );
          }),
          GetBuilder<SignUpPageControllerImp>(builder: (controller) {
            return ElevatedButton(
              onPressed: () {
                if (!controller.isLodaing) {
                  controller.signUp();
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(110, 40),
                  backgroundColor: AppColors.primaryColor),
              child: controller.isLodaing
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "Sign Up".tr,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
            );
          }),
        ],
      ),
    );
  }
}
