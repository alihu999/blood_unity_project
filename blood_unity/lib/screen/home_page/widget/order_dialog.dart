import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_page_controller.dart';

class OrderDialog extends GetView<HomePageControllerImp> {
  const OrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.5,
    );
  }
}
/*FutureBuilder(
          future: controller.getOrderDonating(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Text("${snapshot.data![index]["name"]}");
                  });
            } else {
              return const Center(
                child: Text(
                  "Not Data found",
                  style: TextStyle(color: Colors.black, fontSize: 50),
                ),
              );
            }
          }), */