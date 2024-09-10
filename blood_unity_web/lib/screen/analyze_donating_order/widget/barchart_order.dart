import 'package:blood_unity_web/core/constant/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/analyze_donating_order_controller.dart';

class BarCartOrder extends GetView<AnalyzeDonatingOrderControllerImp> {
  const BarCartOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeDonatingOrderControllerImp>(builder: (context) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Chart by year",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                padding: const EdgeInsets.only(right: 8, left: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryColor)),
                child: DropdownButton<String>(
                    underline: Container(),
                    value: controller.selectedYear,
                    items: List.generate(
                        controller.flch.keys.toList().length,
                        (index) => DropdownMenuItem(
                              value: controller.flch.keys
                                  .toList()[index]
                                  .toString(),
                              child: Text(controller.flch.keys
                                  .toList()[index]
                                  .toString()),
                            )),
                    onChanged: (val) {
                      controller.selectedYear = val!;
                      controller.update();
                    }),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 400,
            child: BarChart(BarChartData(
                maxY: controller.flch[controller.selectedYear]!
                        .reduce((currentMax, next) =>
                            currentMax > next ? currentMax : next)
                        .toDouble() +
                    3,
                titlesData: const FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                        axisNameWidget: Text("Month"),
                        sideTitles: SideTitles(
                            showTitles: true, reservedSize: 30, interval: 3)),
                    leftTitles: AxisTitles(
                        axisNameWidget: Text("Order"),
                        sideTitles: SideTitles(
                            showTitles: true, reservedSize: 30, interval: 1)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false))),
                groupsSpace: 12,
                gridData: FlGridData(drawHorizontalLine: GetPlatform.isDesktop),
                barGroups: List.generate(
                    12,
                    (index) => BarChartGroupData(x: index + 1, barRods: [
                          BarChartRodData(
                              color: AppColors.primaryColor,
                              toY: controller
                                  .flch[controller.selectedYear]![index]
                                  .toDouble())
                        ])))),
          ),
        ],
      );
    });
  }
}
