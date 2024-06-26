import 'package:blood_unity/core/constant/app_color.dart';
import 'package:blood_unity/core/constant/blood_group.dart';
import 'package:blood_unity/core/share/custome_textfield.dart';
import 'package:blood_unity/core/share/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/donating_page_controller.dart';
import 'widget/governorate_dropdown.dart';

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
              const GovernorateDrowpdown(),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<DonatingPageControllerImp>(builder: (controller) {
                return SegmentedButton(
                  showSelectedIcon: false,
                  style: SegmentedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryColor)),
                  segments: List.generate(bloodGroup.length, (index) {
                    return ButtonSegment(
                        value: bloodGroup[index],
                        label: Text(bloodGroup[index]));
                  }),
                  selected: {controller.bloodtype},
                  onSelectionChanged: (val) {
                    controller.bloodtype = val.first;
                    controller.update();
                  },
                );
              }),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<DonatingPageControllerImp>(builder: (controller) {
                return SegmentedButton(
                  showSelectedIcon: false,
                  style: SegmentedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryColor)),
                  segments: const [
                    ButtonSegment(
                        value: "Rh+",
                        label: Text("Rh+", textDirection: TextDirection.ltr)),
                    ButtonSegment(
                        value: "Rh-",
                        label: Text("Rh-", textDirection: TextDirection.ltr))
                  ],
                  selected: {controller.rh},
                  onSelectionChanged: (val) {
                    controller.rh = val.first;
                    controller.update();
                  },
                );
              }),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<DonatingPageControllerImp>(builder: (controller) {
                return ElevatedButton(
                  onPressed: () {
                    controller.confirmOrder();
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
                          "confirm".tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
