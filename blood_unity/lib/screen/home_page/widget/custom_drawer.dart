import 'package:blood_unity/core/constant/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controller/home_page_controller.dart';
import '../../../controller/order_controller.dart';
import 'donating_orders.dart';
import 'obtain_order.dart';

class CustomDrawer extends GetView<HomePageControllerImp> {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: const EdgeInsets.only(left: 15),
              alignment: Alignment.center,
              height: 250,
              color: AppColors.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.user.photoURL == null
                      ? CircleAvatar(
                          minRadius: 50,
                          child: Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                            size: 40,
                          ),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage("${controller.user.photoURL}")),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${controller.user.displayName}",
                    style: const TextStyle(color: Colors.white, fontSize: 19),
                  ),
                  Text(
                    "${controller.user.email}",
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              )),
          const SizedBox(height: 20),
          ListTile(
            trailing:
                Icon(Icons.bookmark, color: AppColors.primaryColor, size: 30),
            title: Text("order".tr, style: const TextStyle(fontSize: 17)),
            onTap: () {
              Get.put(OrderController());
              Get.defaultDialog(
                  title: "order".tr,
                  content: SizedBox(
                    width: width * 0.8,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Donating a unit of blood".tr,
                            style: const TextStyle(fontSize: 15),
                          ),
                          trailing: const Icon(Icons.bookmark_border),
                          onTap: () {
                            Get.defaultDialog(
                                title: "Donating a unit of blood".tr,
                                content: const DonatingOrders());
                          },
                        ),
                        ListTile(
                          title: Text(
                            "Obtain a unit of blood".tr,
                            style: const TextStyle(fontSize: 15),
                          ),
                          trailing: const Icon(Icons.bookmark_border),
                          onTap: () {
                            Get.defaultDialog(
                                title: "Obtain a unit of blood".tr,
                                content: const ObtainOrders());
                          },
                        )
                      ],
                    ),
                  ));
            },
          ),
          const SizedBox(height: 20),
          ListTile(
            trailing: Icon(Icons.contact_support,
                color: AppColors.primaryColor, size: 30),
            title: Text(
              "connect us".tr,
              style: const TextStyle(fontSize: 17),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            indent: 40,
            endIndent: 40,
          ),
          const SizedBox(height: 20),
          ListTile(
            trailing:
                Icon(Icons.logout, color: AppColors.primaryColor, size: 30),
            title: Text("sign out".tr, style: const TextStyle(fontSize: 17)),
            onTap: () {
              controller.signOut();
            },
          ),
        ],
      ),
    ));
  }
}
