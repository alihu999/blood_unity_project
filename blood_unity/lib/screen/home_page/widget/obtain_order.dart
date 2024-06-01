import 'package:blood_unity/core/share/datetime_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/order_controller.dart';
import '../../../core/constant/app_color.dart';

class ObtainOrders extends GetView<OrderController> {
  const ObtainOrders({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double highte = MediaQuery.of(context).size.height;

    return SizedBox(
      height: highte * 0.4,
      width: width * 0.8,
      child: FutureBuilder(
          future: controller.getOrderOptin(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.article,
                          size: 30, color: AppColors.primaryColor),
                      title: Text("${snapshot.data![index]["name"]}",
                          style: const TextStyle(fontSize: 18)),
                      subtitle: Text(
                          "${dateTimeFormat(snapshot.data![index]["date"].seconds * 1000)}"),
                      onTap: () {
                        controller.updateOptain(
                            snapshot.data![index]["name"],
                            snapshot.data![index]["phone"],
                            snapshot.data![index]["Health status"],
                            snapshot.data![index]["number of Units"],
                            snapshot.data![index]["governorate"],
                            snapshot.data![index]["bloodtyp"],
                            snapshot.data![index].id);
                      },
                    );
                  });
            } else {
              return Center(
                child: Text(
                  "There are no previous order".tr,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }
          }),
    );
  }
}
/*ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: controller.sharedPrefLang == "en"
                          ? null
                          : const Icon(Icons.article),
                      trailing: controller.sharedPrefLang == "ar"
                          ? null
                          : const Icon(Icons.article),
                      title: Text(
                        "${snapshot.data![index]["name"]}",
                        textDirection: controller.sharedPrefLang == "en"
                            ? TextDirection.rtl
                            : null,
                      ),
                    );
                  }); */



                  /**ExpansionTile(
                      expandedAlignment: Alignment.topLeft,
                      title: Text(
                        "${snapshot.data![index]["name"]}",
                        textDirection: controller.sharedPrefLang == "en"
                            ? TextDirection.rtl
                            : null,
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${"phone".tr}:${snapshot.data![index]["phone"]}",
                            ),
                            Text(
                                "${"Health status".tr}:${snapshot.data![index]["Health status"]}"),
                            Text(
                                "${"bloodtyp".tr}:${snapshot.data![index]["bloodtyp"]}"),
                            Text(
                                "${"number of Units".tr}:${snapshot.data![index]["number of Units"]}"),
                            Text(
                                "${"status".tr}:${snapshot.data![index]["status"]}"),
                            Text(
                                "${"date".tr}:${dateTimeFormat(snapshot.data![index]["date"].seconds * 1000)}"),
                          ],
                        )
                      ],
                    ); */