import 'package:blood_unity/core/constant/app_color.dart';
import 'package:blood_unity/core/constant/dropdown.dart';
import 'package:blood_unity/core/share/custome_textfield.dart';
import 'package:blood_unity/core/share/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/donating_page_controller.dart';

class DonatingPage extends StatelessWidget {
  const DonatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    DonatingPageControllerImp controller = Get.put(DonatingPageControllerImp());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Donating a unit of blood".tr,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              CustomTextFiled(
                isPassword: false,
                lable: "First Name".tr,
                filedColors: AppColors.primaryColor,
                validator: (val) {
                  return nameValidation(val!);
                },
                suffixicon: const Icon(Icons.person),
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
              const SizedBox(
                height: 30,
              ),
              CustomTextFiled(
                isPassword: false,
                lable: "Last Name".tr,
                filedColors: AppColors.primaryColor,
                validator: (val) {
                  return nameValidation(val!);
                },
                suffixicon: const Icon(Icons.person),
                textController: controller.lastName,
                formState: controller.lastNameFormState,
                focusNode: controller.lastNameFocusNode,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (val) {
                  if (controller.lastNameFormState.currentState!.validate()) {
                    FocusScope.of(context)
                        .requestFocus(controller.phoneFocusNode);
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFiled(
                isPassword: false,
                lable: "Phone".tr,
                filedColors: AppColors.primaryColor,
                validator: (val) {
                  return phoneValidation(val!);
                },
                suffixicon: const Icon(Icons.phone),
                textController: controller.phone,
                formState: controller.phoneFormState,
                focusNode: controller.phoneFocusNode,
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (val) {
                  if (controller.phoneFormState.currentState!.validate()) {
                    FocusScope.of(context)
                        .requestFocus(controller.maladyFocusNode);
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFiled(
                isPassword: false,
                lable: "Permanent malady".tr,
                filedColors: AppColors.primaryColor,
                validator: null,
                suffixicon: const Icon(Icons.local_hospital),
                textController: controller.malady,
                formState: controller.maladyFormState,
                focusNode: controller.maladyFocusNode,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (val) {
                  FocusScope.of(context)
                      .requestFocus(controller.governorateFocusNode);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: controller.governorateFormState,
                child: DropdownButtonFormField(
                  hint: Text(
                    "governorate",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  isDense: true,
                  focusNode: controller.governorateFocusNode,
                  validator: (value) {
                    return controller.governorate.value == ""
                        ? "please select governorate"
                        : null;
                  },
                  items: List.generate(governorates.length, (index) {
                    return DropdownMenuItem(
                      value: governorates[index],
                      child: Text(governorates[index]),
                    );
                  }),
                  onChanged: (value) {
                    controller.governorate.value = value.toString();
                  },
                  isExpanded: true,
                  iconEnabledColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.red),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
