import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Auth/signin_page_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/share/custome_textfield.dart';
import '../../../../core/share/validation.dart';

class EmailPasswordContainer extends GetView<SignInControllerImp> {
  const EmailPasswordContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20),
      margin: const EdgeInsets.only(bottom: 40),
      height: hight * 0.4,
      width: width * 0.9,
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
            lable: "Email".tr,
            filedColors: AppColors.primaryColor,
            suffixicon: const Icon(Icons.email),
            validator: (val) {
              return emailValidation(val!);
            },
            textController: controller.email,
            formState: controller.emailFormState,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            onFieldSubmitted: (val) {
              if (controller.emailFormState.currentState!.validate()) {
                FocusScope.of(context)
                    .requestFocus(controller.passwordFocusNode);
              }
            },
          ),
          GetBuilder<SignInControllerImp>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFiled(
                  isPassword: !controller.passwordVisible,
                  lable: "Password".tr,
                  filedColors: AppColors.primaryColor,
                  validator: (val) {
                    return passwordValidation(val!);
                  },
                  onFieldSubmitted: (val) {
                    controller.passwordFormState.currentState!.validate();
                  },
                  focusNode: controller.passwordFocusNode,
                  textController: controller.password,
                  formState: controller.passwordFormState,
                  keyboardType: TextInputType.emailAddress,
                  suffixicon: IconButton(
                      onPressed: () {
                        controller.showHidePassword();
                      },
                      icon: Icon(controller.passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off)),
                ),
                TextButton(
                    onPressed: () {
                      controller.forgetPassword();
                    },
                    child: Text(
                      "Forget Password".tr,
                    )),
              ],
            );
          }),
          GetBuilder<SignInControllerImp>(builder: (controller) {
            return ElevatedButton(
              onPressed: () {
                controller.signIn();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(110, 40),
                  backgroundColor: AppColors.primaryColor),
              child: controller.isLoading
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "Sign In".tr,
                      style: const TextStyle(color: Colors.white),
                    ),
            );
          }),
        ],
      ),
    );
  }
}
