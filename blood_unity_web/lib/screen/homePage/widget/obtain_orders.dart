import 'package:blood_unity_web/controller/home_page_controller.dart';
import 'package:blood_unity_web/core/constant/app_colors.dart';
import 'package:blood_unity_web/core/share/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/share/firebase_function.dart';
import 'search_bar.dart';

class ObtainOrders extends GetView<HomePageControllerImp> {
  const ObtainOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomSearchBar(
              searchIn: 'obtain',
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GetBuilder<HomePageControllerImp>(builder: (controller) {
                  return FutureBuilder(
                      future: getObtainOrders(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.data!.isNotEmpty) {
                          return DataTable(
                            headingRowColor: MaterialStatePropertyAll(
                                AppColors.primaryColor),
                            headingTextStyle:
                                const TextStyle(color: Colors.white),
                            columns: const [
                              DataColumn(label: Text("Name")),
                              DataColumn(label: Text("Phone")),
                              DataColumn(label: Text("Date")),
                              DataColumn(label: Text("Governorate")),
                              DataColumn(label: Text("Health status")),
                              DataColumn(label: Text("Blood type")),
                              DataColumn(label: Text("number of Units")),
                              DataColumn(label: Text("Status"))
                            ],
                            rows: List.generate(
                              snapshot.data!.length,
                              (index) => DataRow(
                                  color: MaterialStatePropertyAll(index % 2 != 0
                                      ? AppColors.primaryColor.withOpacity(0.20)
                                      : Colors.grey[100]),
                                  cells: [
                                    DataCell(Text(
                                        "${snapshot.data![index]["name"]}")),
                                    DataCell(Text(
                                        "${snapshot.data![index]["phone"]}")),
                                    DataCell(Text(dateTimeFormat(
                                        snapshot.data![index]["date"].seconds *
                                            1000))),
                                    DataCell(Text(
                                        "${snapshot.data![index]["governorate"]}")),
                                    DataCell(Text(
                                        "${snapshot.data![index]["Health status"]}")),
                                    DataCell(Text(
                                        "${snapshot.data![index]["bloodtyp"]}")),
                                    DataCell(Text(
                                        "${snapshot.data![index]["number of Units"]}")),
                                    DataCell(DropdownButton<String>(
                                        value:
                                            "${snapshot.data![index]["status"]}",
                                        items: const [
                                          DropdownMenuItem(
                                            value: "new",
                                            child: Text("new"),
                                          ),
                                          DropdownMenuItem(
                                            value: "processing",
                                            child: Text("processing"),
                                          ),
                                          DropdownMenuItem(
                                            value: "completed",
                                            child: Text("completed"),
                                          ),
                                          DropdownMenuItem(
                                            value: "cancelled",
                                            child: Text("cancelled"),
                                          )
                                        ],
                                        onChanged: (val) {
                                          if (val != null) {
                                            controller.changeOrderStatus(
                                                "obtain_order",
                                                snapshot.data![index].id,
                                                val);
                                          }
                                        })),
                                  ]),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text(
                              "Not Data found",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 50),
                            ),
                          );
                        }
                      });
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
