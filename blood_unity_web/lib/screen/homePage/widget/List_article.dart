import 'package:blood_unity_web/screen/homePage/widget/confirm_delete_article.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_page_controller.dart';
import '../../../core/constant/app_colors.dart';

class ListArticle extends GetView<HomePageControllerImp> {
  const ListArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImp>(builder: (context) {
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                              child: Material(
                            color: AppColors.primaryColor, // Button color
                            child: InkWell(
                              onTap: () {
                                Get.defaultDialog(
                                    title: "Delete Article",
                                    content: ConfirmDeleteArticle(
                                        id: snapshot.data![index].id,
                                        photoUrl: snapshot.data![index]
                                            ["urlimage"],
                                        fileUrl: snapshot.data![index]
                                            ["urlpdf"]));
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
                            borderRadius: BorderRadius.circular(25),
                            elevation: 8,
                            child: Container(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                height: 100,
                                width: 400,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25)),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://cors-anywhere.herokuapp.com/${snapshot.data![index]["urlimage"]}"))),
                                    ),
                                    Text(
                                      snapshot.data![index]["title"],
                                      style: const TextStyle(fontSize: 17),
                                    )
                                  ],
                                )),
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
