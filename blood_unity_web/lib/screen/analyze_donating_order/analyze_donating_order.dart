import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/analyze_donating_order_controller.dart';
import 'widget/all_order.dart';
import 'widget/blood_type.dart';

class AnalyzeDonatingOrder extends StatelessWidget {
  const AnalyzeDonatingOrder({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AnalyzeDonatingOrderControllerImp());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AllOrder(),
              SizedBox(
                height: 30,
              ),
              BloodType()
            ],
          ),
        ),
      ),
    );
  }
}
