import 'package:blood_unity/controller/home_page_controller.dart';
import 'package:blood_unity/core/constant/app_color.dart';
import 'package:blood_unity/core/constant/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/article.dart';
import 'widget/custom_drawer.dart';
import 'widget/news_ar.dart';
import 'widget/news_en.dart';
import 'widget/notification.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageControllerImp controller = Get.put(HomePageControllerImp());
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          shadowColor: Colors.grey,
          elevation: 7,
          title: const Text(
            "Blood Unity",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.openNotificationDialog();
                  },
                ))
          ],
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.local_hospital_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.newspaper_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ]),
        ),
        drawer: const CustomDrawer(),
        body: TabBarView(children: [
          controller.sharedPrefLang == "en" ? const NewsEn() : const NewsAr(),
          const Article()
        ]),
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Get.defaultDialog(
                  title: "add orders".tr,
                  content: SizedBox(
                    width: width * 0.8,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Donating a unit of blood".tr,
                            style: const TextStyle(fontSize: 15),
                          ),
                          trailing: const Icon(Icons.bloodtype),
                          onTap: () {
                            Get.toNamed(AppRoutes.donatingPage, arguments: {});
                          },
                        ),
                        ListTile(
                          title: Text(
                            "Obtain a unit of blood".tr,
                            style: const TextStyle(fontSize: 15),
                          ),
                          trailing: const Icon(Icons.bloodtype),
                          onTap: () {
                            Get.toNamed(AppRoutes.obtainPage, arguments: {});
                          },
                        )
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
