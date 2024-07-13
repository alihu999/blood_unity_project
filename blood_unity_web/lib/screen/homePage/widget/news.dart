import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_page_controller.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/share/date_time_format.dart';
import 'confirm_delete_event.dart';

class News extends GetView<HomePageControllerImp> {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImp>(builder: (controller) {
      return FutureBuilder(
          future: controller.getNews(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                              child: Material(
                            color: AppColors.primaryColor, // Button color
                            child: InkWell(
                              onTap: () {
                                Get.defaultDialog(
                                    title: "Delete event",
                                    content: ConfirmDelete(
                                      id: snapshot.data![index].id,
                                    ));
                              },
                              child: const SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 30,
                          ),
                          PhysicalModel(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            elevation: 8,
                            child: SizedBox(
                              height: 100,
                              width: 400,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${snapshot.data![index]['title']}",
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 100, 100, 100))),
                                          const SizedBox(width: 10),
                                          const Icon(Icons.title),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            dateTimeFormat(snapshot
                                                    .data![index]['date']
                                                    .seconds *
                                                1000),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 100, 100, 100)),
                                          ),
                                          const SizedBox(width: 10),
                                          const Icon(Icons.date_range),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${snapshot.data![index]['location']}",
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 100, 100, 100)),
                                          ),
                                          const SizedBox(width: 10),
                                          const Icon(
                                              Icons.location_on_outlined),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 100,
                                    width: 15,
                                    margin: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text(
                  "Not Data found",
                  style: TextStyle(color: Colors.black, fontSize: 50),
                ),
              );
            }
          });
    });
  }
}
