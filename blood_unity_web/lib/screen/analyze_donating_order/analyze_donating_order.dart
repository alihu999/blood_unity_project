import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/analyze_donating_order_controller.dart';
import 'widget/all_order.dart';
import 'widget/blood_type.dart';
import 'widget/barchart_order.dart';

class AnalyzeDonatingOrder extends StatelessWidget {
  const AnalyzeDonatingOrder({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AnalyzeDonatingOrderControllerImp());
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: GetX<AnalyzeDonatingOrderControllerImp>(builder: (controller) {
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
