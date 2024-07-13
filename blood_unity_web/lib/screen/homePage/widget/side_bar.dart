import 'package:blood_unity_web/controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_colors.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HomePageControllerImp>(builder: (controller) {
      return NavigationRail(
          backgroundColor: AppColors.primaryColor,
          useIndicator: false,
          groupAlignment: 0,
          labelType: NavigationRailLabelType.selected,
          selectedLabelTextStyle:
              const TextStyle(fontSize: 14, color: Colors.white),
          unselectedIconTheme:
              const IconThemeData(color: Colors.white60, size: 27),
          selectedIconTheme: const IconThemeData(size: 35, color: Colors.white),
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          destinations: const [
            NavigationRailDestination(
                icon: Icon(Icons.event), label: Text("Event")),
            NavigationRailDestination(
                icon: Icon(Icons.local_hospital), label: Text("Article")),
            NavigationRailDestination(
                icon: Icon(Icons.file_copy), label: Text("Obtain order")),
            NavigationRailDestination(
                icon: Icon(Icons.file_copy), label: Text("Donating order"))
          ],
          selectedIndex: controller.selectedIndex.value);
    });
  }
}
