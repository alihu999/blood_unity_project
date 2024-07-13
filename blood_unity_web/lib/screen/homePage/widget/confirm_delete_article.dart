import 'package:blood_unity_web/controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDeleteArticle extends GetView<HomePageControllerImp> {
  final String id;
  final String photoUrl;
  final String fileUrl;
  const ConfirmDeleteArticle(
      {super.key,
      required this.id,
      required this.photoUrl,
      required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Do you want to delete this article?",
            style: TextStyle(fontSize: 17),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 30,
                  ),
                  label: const Text(
                    "No",
                    style: TextStyle(color: Colors.red, fontSize: 17),
                  )),
              ElevatedButton.icon(
                  onPressed: () {
                    controller.deletArticle(id, photoUrl, fileUrl);
                  },
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 30,
                  ),
                  label: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.green, fontSize: 17),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
