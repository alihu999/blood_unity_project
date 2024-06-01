import 'package:blood_unity/controller/home_page_controller.dart';
import 'package:blood_unity/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double highte = MediaQuery.of(context).size.height;
    return GetX<HomePageControllerImp>(builder: (controller) {
      return SizedBox(
          height: highte * 0.4,
          width: width * 0.8,
          child: controller.notifications.isEmpty
              ? const Center(
                  child: Text("There are no notifications"),
                )
              : ListView.builder(
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: controller.notifications[index].status == "new"
                          ? AppColors.primaryColor.withOpacity(0.15)
                          : null,
                      title: Text(
                        controller.notifications[index].title,
                        style: TextStyle(
                            fontSize: 17, color: AppColors.primaryColor),
                        textDirection: TextDirection.rtl,
                      ),
                      subtitle: Text(controller.notifications[index].text,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(fontSize: 12)),
                      leading: const Text("5 h"),
                    );
                  }));
    });
  }
}
/**ListTile(
              title: Text(
                "تبرع بالدم",
                style: TextStyle(fontSize: 17, color: AppColors.primaryColor),
                textDirection: TextDirection.rtl,
              ),
              subtitle: const Text(
                  " المشفى الوطني في طرطوس بحاجة ماسة الى جميع انواع الزمر الدموية",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 12)),
              leading: const Text("5 h"),
            ), */