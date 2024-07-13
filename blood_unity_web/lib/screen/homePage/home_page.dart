import 'package:blood_unity_web/core/constant/app_route.dart';
import 'package:blood_unity_web/screen/homePage/widget/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_page_controller.dart';
import 'widget/article.dart';
import 'widget/donating_orders.dart';
import 'widget/event.dart';
import 'widget/add_floating_button.dart';
import 'widget/obtain_orders.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Get.put(HomePageControllerImp());

    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GetX<HomePageControllerImp>(
            builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SideBar(),
                  if (controller.selectedIndex.value == 0) const Event(),
                  if (controller.selectedIndex.value == 1) const Article(),
                  if (controller.selectedIndex.value == 2) const ObtainOrders(),
                  if (controller.selectedIndex.value == 3)
                    const DonatingOrders(),
                ],
              );
            },
          ),
        ),
        floatingActionButton:
            GetX<HomePageControllerImp>(builder: (controller) {
          if (width < 1000 &&
              (controller.selectedIndex.value == 0 ||
                  controller.selectedIndex.value == 1)) {
            return const AddFloatingButton();
          } else if (controller.selectedIndex.value == 2) {
            return FloatingActionButton(
                child: const Icon(
                  Icons.bar_chart,
                  size: 30,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.analyzeObtainOrder);
                });
          } else if (controller.selectedIndex.value == 3) {
            return FloatingActionButton(
                child: const Icon(
                  Icons.bar_chart,
                  size: 30,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.analyzeDonatingOrder);
                });
          } else {
            controller.selectedIndex.value;
            return const SizedBox();
          }
        }));
  }
}
