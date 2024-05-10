import 'package:blood_unity/core/constant/blood_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/obtain_page_controller.dart';
import '../../core/constant/app_color.dart';
import '../../core/share/custome_textfield.dart';
import '../../core/share/validation.dart';
import 'widget/governorate_dropdown.dart';

class ObtainPage extends StatelessWidget {
  const ObtainPage({super.key});

  @override
  Widget build(BuildContext context) {
    ObtainPageControllerImp controller = Get.put(ObtainPageControllerImp());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Obtain a unit of blood".tr,
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
                        .requestFocus(controller.statusFocusNode);
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFiled(
                isPassword: false,
                lable: "Health status".tr,
                filedColors: AppColors.primaryColor,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "You must enter health status".tr;
                  } else {
                    return null;
                  }
                },
                suffixicon: const Icon(Icons.local_hospital),
                textController: controller.status,
                formState: controller.statusFormState,
                focusNode: controller.statusFocusNode,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (val) {
                  if (controller.statusFormState.currentState!.validate()) {
                    FocusScope.of(context)
                        .requestFocus(controller.numberUnitsFocusNode);
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFiled(
                isPassword: false,
                lable: "Number of units".tr,
                filedColors: AppColors.primaryColor,
                validator: (val) {
                  if (val == null) {
                    return "You must enter the number of units";
                  } else {
                    return null;
                  }
                },
                suffixicon: const Icon(Icons.numbers),
                textController: controller.numberUnits,
                formState: controller.numberUnitsFormState,
                focusNode: controller.numberUnitsFocusNode,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (val) {
                  if (controller.numberUnitsFormState.currentState!
                      .validate()) {
                    FocusScope.of(context)
                        .requestFocus(controller.governorateFocusNode);
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const GovernorateDrowpdown(),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<ObtainPageControllerImp>(builder: (controller) {
                return SegmentedButton(
                  showSelectedIcon: false,
                  multiSelectionEnabled: true,
                  style: SegmentedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryColor)),
                  segments: List.generate(bloodGropP.length, (index) {
                    return ButtonSegment(
                        value: bloodGropP[index],
                        label: Text(
                          bloodGropP[index],
                          textDirection: TextDirection.ltr,
                        ));
                  }),
                  selected: controller.bloodtypeP,
                  onSelectionChanged: (val) {
                    controller.bloodtypeP = val;
                    controller.update();
                  },
                );
              }),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<ObtainPageControllerImp>(builder: (controller) {
                return SegmentedButton(
                  multiSelectionEnabled: true,
                  showSelectedIcon: false,
                  style: SegmentedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryColor)),
                  segments: List.generate(bloodGropN.length, (index) {
                    return ButtonSegment(
                        value: bloodGropN[index],
                        label: Text(
                          bloodGropN[index],
                          textDirection: TextDirection.ltr,
                        ));
                  }),
                  selected: controller.bloodtypeN,
                  onSelectionChanged: (val) {
                    controller.bloodtypeN = val;
                    controller.update();
                  },
                );
              }),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<ObtainPageControllerImp>(builder: (controller) {
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
