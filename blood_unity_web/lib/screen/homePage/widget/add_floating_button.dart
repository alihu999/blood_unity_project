import 'package:blood_unity_web/screen/homePage/widget/add_article.dart';
import 'package:blood_unity_web/screen/homePage/widget/add_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class AddFloatingButton extends StatelessWidget {
  const AddFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      children: [
        SpeedDialChild(
            shape: const CircleBorder(),
            child: const Icon(
              Icons.local_hospital_outlined,
            ),
            label: "Add Event",
            onTap: () {
              Get.defaultDialog(title: "Add Event", content: const AddEvent());
            }),
        SpeedDialChild(
            shape: const CircleBorder(),
            child: const Icon(
              Icons.article,
            ),
            label: "Add Article",
            onTap: () {
              Get.defaultDialog(
                  title: "Add Event", content: const AddArticle());
            })
      ],
      child: const Icon(Icons.add),
    );
  }
}
