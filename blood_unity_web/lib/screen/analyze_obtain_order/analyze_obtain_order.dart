import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/analyze_obtain_order_controller.dart';
import 'wideget/all_order.dart';
import 'wideget/barchart_order.dart';
import 'wideget/blood_type.dart';

class AnalyzeObtainOrder extends StatelessWidget {
  const AnalyzeObtainOrder({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AnalyzeObtainOrderControllerImp());
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: GetX<AnalyzeObtainOrderControllerImp>(builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AllOrder(),
                    SizedBox(
                      height: 30,
                    ),
                    BloodType(),
                    SizedBox(
                      height: 30,
                    ),
                    BarCartOrder()
                  ],
                ),
              ),
            );
          }
        }));
  }
}
