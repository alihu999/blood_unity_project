import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/obtain_page_controller.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/dropdown.dart';

class GovernorateDrowpdown extends GetView<ObtainPageControllerImp> {
  const GovernorateDrowpdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.governorateFormState,
      child: DropdownButtonFormField(
        menuMaxHeight: 200,
        value: controller.governorate,
        borderRadius: const BorderRadius.all(Radius.zero),
        hint: Text(
          "governorate".tr,
          style: TextStyle(color: AppColors.primaryColor),
        ),
        focusNode: controller.governorateFocusNode,
        validator: (value) {
          return controller.governorate == ""
              ? "please select governorate"
              : null;
        },
        items: List.generate(governorates.length, (index) {
          return DropdownMenuItem<String>(
            value: governorates[index],
            child: Text(governorates[index].tr),
          );
        }),
        onChanged: (value) {
          controller.governorate = value.toString();
        },
        isExpanded: true,
        iconEnabledColor: AppColors.primaryColor,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
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
    );
  }
}
