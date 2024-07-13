import 'package:blood_unity_web/controller/home_page_controller.dart';
import 'package:blood_unity_web/screen/homePage/widget/donating_search_res.dart';
import 'package:blood_unity_web/screen/homePage/widget/obtain_search_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchBar extends GetView<HomePageControllerImp> {
  final String searchIn;
  const CustomSearchBar({super.key, required this.searchIn});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.searchFormState,
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: 350,
        height: 40,
        child: SearchBar(
          onSubmitted: (value) {
            Get.defaultDialog(
                title: "search response",
                content: searchIn == "obtain"
                    ? const ObtainSearchRes()
                    : const DonatingSearchRes());
          },
          overlayColor: const MaterialStatePropertyAll(Colors.white),
          controller: controller.search,
          hintText: "Search",
        ),
      ),
    );
  }
}
