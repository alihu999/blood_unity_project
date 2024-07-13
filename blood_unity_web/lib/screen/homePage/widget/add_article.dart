import 'package:blood_unity_web/controller/home_page_controller.dart';
import 'package:blood_unity_web/core/constant/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../core/share/custom_textfiled.dart';

class AddArticle extends GetView<HomePageControllerImp> {
  const AddArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<HomePageControllerImp>(builder: (controller) {
          return DottedBorder(
            dashPattern: const [6, 3, 2, 3],
            borderType: BorderType.RRect,
            radius: const Radius.circular(25),
            padding: const EdgeInsets.all(4),
            child: InkWell(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: controller.articlePhoto == null
                      ? AppColors.primaryColor.withOpacity(0.20)
                      : Colors.white,
                  child: controller.articlePhoto == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Colors.black,
                              size: 50,
                            ),
                            Text("select photo")
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image_outlined,
                              color: Colors.black,
                              size: 50,
                            ),
                            Text(controller.articlePhoto!.name)
                          ],
                        ),
                ),
              ),
              onTap: () async {
                final result = await FilePicker.platform
                    .pickFiles(allowMultiple: false, type: FileType.image);
                controller.articlePhoto = result!.files.first;
                controller.update();
              },
            ),
          );
        }),
        const SizedBox(
          height: 30,
        ),
        GetBuilder<HomePageControllerImp>(builder: (controller) {
          return DottedBorder(
            dashPattern: const [6, 3, 2, 3],
            borderType: BorderType.RRect,
            radius: const Radius.circular(25),
            padding: const EdgeInsets.all(4),
            child: InkWell(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: controller.articleFile == null
                      ? AppColors.primaryColor.withOpacity(0.20)
                      : Colors.white,
                  child: controller.articleFile == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_copy_outlined,
                              color: Colors.black,
                              size: 50,
                            ),
                            Text("select pdf file")
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.picture_as_pdf_outlined,
                              color: Colors.black,
                              size: 50,
                            ),
                            Text(controller.articleFile!.name)
                          ],
                        ),
                ),
              ),
              onTap: () async {
                final result = await FilePicker.platform
                    .pickFiles(allowMultiple: false, type: FileType.any);
                controller.articleFile = result!.files.first;
                controller.update();
              },
            ),
          );
        }),
        const SizedBox(
          height: 30,
        ),
        CustomTextFiled(
          lable: 'Title',
          filedColors: AppColors.primaryColor,
          validator: (val) {
            if (val!.isEmpty) {
              return "cannot be Empty";
            } else {
              return null;
            }
          },
          textController: controller.articleTitle,
          formState: controller.articleTitleFormState,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            controller.uploadArticle();
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 40),
              backgroundColor: AppColors.primaryColor),
          child: GetX<HomePageControllerImp>(builder: (context) {
            return controller.articleUpload.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  );
          }),
        )
      ],
    );
  }
}
