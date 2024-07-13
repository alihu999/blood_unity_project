import 'package:blood_unity_web/controller/analyze_donating_order_controller.dart';
import 'package:blood_unity_web/core/constant/app_colors.dart';
import 'package:blood_unity_web/core/share/custom_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/governorates.dart';
import '../../../core/share/calculate_percentage.dart';

class AllOrder extends GetView<AnalyzeDonatingOrderControllerImp> {
  const AllOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeDonatingOrderControllerImp>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Donating Order",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                padding: const EdgeInsets.only(right: 8, left: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryColor)),
                child: DropdownButton<String>(
                    underline: Container(),
                    value: controller.governorates,
                    items: List.generate(
                        governorates.length,
                        (index) => DropdownMenuItem(
                              value: governorates[index],
                              child: Text(governorates[index]),
                            )),
                    onChanged: (val) {
                      controller.governorates = val!;
                      controller.updateData();
                    }),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              CustomBox(
                  title: "All order:",
                  number: "${controller.donatingOrder!.length}",
                  percentage: "100%"),
              CustomBox(
                  title: "Completed orders:",
                  number: "${controller.complatedOrder}",
                  percentage: calculatePercentage(
                      controller.donatingOrder!.length,
                      controller.complatedOrder)),
              CustomBox(
                  title: "New orders:",
                  number: "${controller.newOrder}",
                  percentage: calculatePercentage(
                      controller.donatingOrder!.length, controller.newOrder)),
              CustomBox(
                  title: "Processing orders:",
                  number: "${controller.processingOrder}",
                  percentage: calculatePercentage(
                      controller.donatingOrder!.length,
                      controller.processingOrder)),
              CustomBox(
                  title: "canceled orders:",
                  number: "${controller.cancelledOrder}",
                  percentage: calculatePercentage(
                      controller.donatingOrder!.length,
                      controller.cancelledOrder)),
            ],
          ),
        ],
      );
    });
  }
}
