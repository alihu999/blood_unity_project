import 'package:blood_unity_web/controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/share/date_time_format.dart';

class DonatingSearchRes extends GetView<HomePageControllerImp> {
  const DonatingSearchRes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: GetBuilder<HomePageControllerImp>(builder: (controller) {
            return FutureBuilder(
                future: controller.donatingSearch(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data!.isNotEmpty) {
                    return DataTable(
                      headingRowColor:
                          MaterialStatePropertyAll(AppColors.primaryColor),
                      headingTextStyle: const TextStyle(color: Colors.white),
                      columns: const [
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Phone")),
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Governorate")),
                        DataColumn(label: Text("malady")),
                        DataColumn(label: Text("Blood type")),
                        DataColumn(label: Text("Rh")),
                        DataColumn(label: Text("Status"))
                      ],
                      rows: List.generate(
                        snapshot.data!.length,
                        (index) => DataRow(
                            color: MaterialStatePropertyAll(index % 2 != 0
                                ? AppColors.primaryColor.withOpacity(0.20)
                                : Colors.grey[100]),
                            cells: [
                              DataCell(
                                  Text("${snapshot.data![index]["name"]}")),
                              DataCell(
                                  Text("${snapshot.data![index]["phone"]}")),
                              DataCell(Text(dateTimeFormat(
                                  snapshot.data![index]["date"].seconds *
                                      1000))),
                              DataCell(Text(
                                  "${snapshot.data![index]["governorate"]}")),
                              DataCell(
                                  Text("${snapshot.data![index]["malady"]}")),
                              DataCell(
                                  Text("${snapshot.data![index]["bloodtyp"]}")),
                              DataCell(Text("${snapshot.data![index]["Rh"]}")),
                              DataCell(DropdownButton<String>(
                                  value: "${snapshot.data![index]["status"]}",
                                  items: const [
                                    DropdownMenuItem(
                                      value: "new",
                                      child: Text("new"),
                                    ),
                                    DropdownMenuItem(
                                      value: "progress",
                                      child: Text("progress"),
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
                                          "donating_order",
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
                        style: TextStyle(color: Colors.black, fontSize: 50),
                      ),
                    );
                  }
                });
          }),
        ),
      ),
    );
  }
}
