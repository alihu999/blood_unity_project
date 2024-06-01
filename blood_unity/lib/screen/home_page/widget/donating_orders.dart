import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/order_controller.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/share/datetime_format.dart';

class DonatingOrders extends GetView<OrderController> {
  const DonatingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double highte = MediaQuery.of(context).size.height;
    return SizedBox(
      height: highte * 0.4,
      width: width * 0.8,
      child: FutureBuilder(
          future: controller.getOrderDonating(),
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
                        controller.updateDonating(
                            snapshot.data![index]["name"],
                            snapshot.data![index]["phone"],
                            snapshot.data![index]["malady"],
                            snapshot.data![index]["governorate"],
                            snapshot.data![index]["bloodtyp"],
                            snapshot.data![index]["Rh"],
                            snapshot.data![index].id);
                      },
                    );
                  });
            } else {
              return Center(
                child: Text(
                  "There are no previous order".tr,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            }
          }),
    );
  }
}
