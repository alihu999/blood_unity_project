import 'package:blood_unity_web/core/share/custom_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/analyze_donating_order_controller.dart';
import '../../../core/share/calculate_percentage.dart';

class BloodType extends StatelessWidget {
  const BloodType({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeDonatingOrderControllerImp>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Blood Types",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomBox(
              title: "Required blood types",
              number: controller.allBloodType.toString(),
              percentage: "100%"),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              CustomBox(
                  title: "O Rh+",
                  number: "${controller.oPtype}",
                  percentage: calculatePercentage(
                      controller.allBloodType, controller.oPtype)),
              CustomBox(
                  title: "A Rh+",
                  number: "${controller.aPtype}",
                  percentage: calculatePercentage(
                      controller.allBloodType, controller.aPtype)),
              CustomBox(
                  title: "B Rh+",
                  number: "${controller.bPtype}",
                  percentage: calculatePercentage(
                      controller.allBloodType, controller.bPtype)),
              CustomBox(
                  title: "AB Rh+",
                  number: "${controller.abPtype}",
                  percentage: calculatePercentage(
                      controller.allBloodType, controller.abPtype)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              CustomBox(
                  title: "O Rh-",
                  number: "${controller.oNtype}",
                  percentage: calculatePercentage(
                      controller.allBloodType, controller.oNtype)),
              CustomBox(
                  title: "A Rh-",
                  number: "${controller.aNtype}",
                  percentage: calculatePercentage(
                      controller.allBloodType, controller.aNtype)),
              CustomBox(
                  title: "B Rh-",
                  number: "${controller.bNtype}",
                  percentage: calculatePercentage(
                      controller.allBloodType, controller.bNtype)),
              CustomBox(
                  title: "AB Rh-",
                  number: "${controller.abNtype}",
                  percentage: calculatePercentage(
                      controller.allBloodType, controller.abNtype)),
            ],
          ),
        ],
      );
    });
  }
}
