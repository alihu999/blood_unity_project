import 'package:blood_unity/controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pdf_view.dart';

class Article extends GetView<HomePageControllerImp> {
  const Article({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: controller.getArticle(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: InkWell(
                      child: PhysicalModel(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        elevation: 8,
                        child: Container(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            height: height * 0.16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: height * 0.14,
                                  width: height * 0.14,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot
                                              .data![index]["urlimage"]))),
                                ),
                                Text(
                                  snapshot.data![index]["title"],
                                  style: const TextStyle(fontSize: 17),
                                )
                              ],
                            )),
                      ),
                      onTap: () {
                        Get.to(const PdfView(), arguments: {
                          "urlimage": snapshot.data![index]["urlimage"],
                          "urlpdf": snapshot.data![index]["urlpdf"]
                        });
                      },
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
