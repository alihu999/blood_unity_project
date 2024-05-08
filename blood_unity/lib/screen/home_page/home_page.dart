import 'package:blood_unity/controller/home_page_controller.dart';
import 'package:blood_unity/core/constant/app_color.dart';
import 'package:blood_unity/core/constant/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/news_ar.dart';
import 'widget/news_en.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageControllerImp controller = Get.put(HomePageControllerImp());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.grey,
          elevation: 7,
          title: const Text(
            "Blood Unity",
            style: TextStyle(color: Colors.white),
          ),
          actions: const [
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.notifications,
                  size: 30,
                  color: Colors.white,
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
        body: TabBarView(children: [
          controller.sharedPrefLang == "en" ? const NewsEn() : const NewsAr(),
          const Center(child: Text("Tab2"))
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
                  title: "Orders".tr,
                  content: Column(
                    children: [
                      ListTile(
                        title: Text("Donating a unit of blood".tr),
                        onTap: () {
                          Get.toNamed(AppRoutes.donatingPage);
                        },
                      ),
                      ListTile(
                        title: Text("Obtain a unit of blood".tr),
                      )
                    ],
                  ));
            }),
      ),
    );
  }
}
