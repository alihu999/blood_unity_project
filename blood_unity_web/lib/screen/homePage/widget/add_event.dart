import 'package:blood_unity_web/controller/home_page_controller.dart';
import 'package:blood_unity_web/core/constant/app_colors.dart';
import 'package:blood_unity_web/core/share/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../core/share/custom_textfiled.dart';
import 'select_time_dialog.dart';

class AddEvent extends GetView<HomePageControllerImp> {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextFiled(
          lable: 'Title',
          filedColors: AppColors.primaryColor,
          validator: (val) {
            if (val!.isEmpty) {
              return "cannot be Empty";
            } else {
              return null;
            }
          },
          textController: controller.title,
          formState: controller.titleFormState,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(
          height: 30,
        ),
        CustomTextFiled(
          lable: 'Location',
          filedColors: AppColors.primaryColor,
          validator: (val) {
            if (val!.isEmpty) {
              return "cannot be Empty";
            } else {
              return null;
            }
          },
          textController: controller.location,
          formState: controller.locationFormState,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GetBuilder<HomePageControllerImp>(builder: (controller) {
              return Text(timeFormat(controller.dateTime));
            }),
            ElevatedButton.icon(
                onPressed: () async {
                  DateTime? date = await selectDateDialog();

                  TimeOfDay? time = await selectTime();
                  if (time != null && date != null) {
                    controller.dateTime = DateTime(date.year, date.month,
                        date.day, time.hour, time.minute);
                    controller.update();
                  }
                },
                icon: const Icon(Icons.date_range),
                label: const Text("Select Date Time"))
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            controller.uploadEvent();
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 40),
              backgroundColor: AppColors.primaryColor),
          child: const Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
