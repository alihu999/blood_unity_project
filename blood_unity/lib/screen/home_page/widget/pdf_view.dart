import 'package:blood_unity/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Map arguments = Get.arguments;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.20),
          child: AppBar(
            flexibleSpace: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10, left: 10),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(arguments["urlimage"]))),
            ),
          )),
      body: const PDF().cachedFromUrl(
        arguments["urlpdf"],
        placeholder: (progress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorWidget: (error) {
          return Center(child: Text(error.toString()));
        },
      ),
    );
  }
}
/*SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text("Title"),
            background: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/blood-unity-cbba1.appspot.com/o/94c4a9eb90ac44a6975f3da910dfa4d2.jpg.webp?alt=media&token=fb064161-3867-46cb-b054-2ab59e031b6f"),
          ),
        ) */

        /*const PDF().cachedFromUrl(
        'https://firebasestorage.googleapis.com/v0/b/blood-unity-cbba1.appspot.com/o/%D9%86%D9%82%D8%B5%20%D8%AD%D8%AC%D9%85%20%D8%A7%D9%84%D8%AF%D9%85.pdf?alt=media&token=7f627cba-e202-48d2-bfd4-8b9760f231f5',
        placeholder: (progress) {
          print(progress);
          return Center(child: Text('$progress %'));
        },
        errorWidget: (error) {
          print(error);
          return Center(child: Text(error.toString()));
        },
      ), */