import 'package:blood_unity/controller/home_page_controller.dart';
import 'package:blood_unity/core/constant/app_color.dart';
import 'package:blood_unity/core/share/datetime_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsEn extends GetView<HomePageControllerImp> {
  const NewsEn({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      elevation: 8,
                      child: SizedBox(
                        height: height * 0.13,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("${snapshot.data![index]['title']}",
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
                                              .data![index]['date'].seconds *
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
                                    const Icon(Icons.location_on_outlined),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              height: height * 0.16,
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
  }
}
