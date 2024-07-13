import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../core/share/custom_snakpar.dart';

abstract class HomePageController extends GetxController {
  Future getNews();
  uploadEvent();
  deletEvent(String id);
  getArticle();
  uploadArticle();
  deletArticle(String id, String photoUrl, String fileUrl);
  changeOrderStatus(String colc, String docID, String status);
  obtainSearch();
  donatingSearch();
}

class HomePageControllerImp extends HomePageController {
  FirebaseFirestore storeInstance = FirebaseFirestore.instance;

  late TextEditingController title;
  late GlobalKey<FormState> titleFormState;

  late TextEditingController location;
  late GlobalKey<FormState> locationFormState;

  late TextEditingController articleTitle;
  late GlobalKey<FormState> articleTitleFormState;

  late TextEditingController search;
  late GlobalKey<FormState> searchFormState;

  DateTime dateTime = DateTime.now();

  RxInt selectedIndex = 0.obs;
  PlatformFile? articlePhoto;
  PlatformFile? articleFile;
  RxBool articleUpload = false.obs;

  @override
  void onInit() {
    title = TextEditingController();
    titleFormState = GlobalKey<FormState>();

    location = TextEditingController();
    locationFormState = GlobalKey<FormState>();

    articleTitle = TextEditingController();
    articleTitleFormState = GlobalKey<FormState>();

    search = TextEditingController();
    searchFormState = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> getNews() async {
    try {
      QuerySnapshot<Map<String, dynamic>> respons = await storeInstance
          .collection('news')
          .orderBy("date", descending: true)
          .get();
      return respons.docs;
    } catch (e) {
      errorSnackBar("$e");
      return null;
    }
  }

  @override
  uploadEvent() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      if (checkValue()) {
        try {
          await storeInstance.collection("news").doc().set({
            "date": dateTime,
            "location": location.text,
            "title": title.text
          });
          Get.back();
          successfulSnackBar("The event was added successfully");
          update();
          title.clear();
          location.clear();
          dateTime = DateTime.now();
        } catch (e) {
          errorSnackBar("$e");
        }
      }
    }
  }

  checkValue() {
    if (titleFormState.currentState!.validate() &&
        locationFormState.currentState!.validate()) {
      if (DateTime.now().compareTo(dateTime) == -1) {
        return true;
      } else {
        errorSnackBar("Please enter a valid date");
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  deletEvent(String id) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      try {
        await storeInstance.collection("news").doc(id).delete();
        Get.back();
        successfulSnackBar("The event was successfully deleted");
        update();
      } catch (e) {
        errorSnackBar("$e");
      }
    }
  }

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      getArticle() async {
    try {
      QuerySnapshot<Map<String, dynamic>> respons =
          await storeInstance.collection('article').get();
      return respons.docs;
    } catch (e) {
      errorSnackBar("$e");
      return null;
    }
  }

  @override
  uploadArticle() async {
    if (articleFile != null && articlePhoto != null) {
      if (articleTitleFormState.currentState!.validate()) {
        if (articleFile!.name.substring(articleFile!.name.indexOf(".") + 1) ==
            "pdf") {
          final connectivityResult = await Connectivity().checkConnectivity();
          if (!connectivityResult.contains(ConnectivityResult.none)) {
            articleUpload.value = true;
            try {
              var resfile = await FirebaseStorage.instance
                  .ref()
                  .child(articleFile!.name)
                  .putData(articleFile!.bytes!);
              var resphoto = await FirebaseStorage.instance
                  .ref()
                  .child(articlePhoto!.name)
                  .putData(articlePhoto!.bytes!);

              await storeInstance.collection("article").doc().set({
                "title": articleTitle.text,
                "urlimage": await resphoto.ref.getDownloadURL(),
                "urlpdf": await resfile.ref.getDownloadURL()
              });
              articleUpload.value = false;
              successfulSnackBar("The article has been uploaded successfully");
              articleFile = null;
              articlePhoto = null;
              articleTitle.clear();
              update();
            } catch (e) {
              errorSnackBar(e.toString());
            }
          }
        } else {
          errorSnackBar("The file type must be 'pdf'");
        }
      }
    } else {
      errorSnackBar("Please select an image and file");
    }
  }

  @override
  deletArticle(String id, String photoUrl, String fileUrl) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      try {
        await storeInstance.collection("article").doc(id).delete();
        //extract file path from the url
        String photoPath =
            FirebaseStorage.instance.refFromURL(photoUrl).fullPath;
        String filePath = FirebaseStorage.instance.refFromURL(fileUrl).fullPath;
        FirebaseStorage.instance.ref().child(photoPath).delete();
        FirebaseStorage.instance.ref().child(filePath).delete();
        Get.back();
        successfulSnackBar("The event was successfully deleted");
        update();
      } catch (e) {
        errorSnackBar("$e");
      }
    }
  }

  @override
  changeOrderStatus(String colc, String docID, String status) async {
    try {
      await storeInstance
          .collection(colc)
          .doc(docID)
          .update({"status": status});
      update();
    } catch (e) {
      errorSnackBar(e.toString());
    }
  }

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      obtainSearch() async {
    try {
      QuerySnapshot<Map<String, dynamic>> respons = await storeInstance
          .collection('obtain_order')
          .orderBy("date", descending: true)
          .where("name", isEqualTo: search.text.trim())
          .get();
      if (respons.docs.isEmpty) {
        respons = await storeInstance
            .collection('obtain_order')
            .orderBy("date", descending: true)
            .where("phone", isEqualTo: search.text.trim())
            .get();
      }
      return respons.docs;
    } catch (e) {
      errorSnackBar("$e");

      return null;
    }
  }

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      donatingSearch() async {
    try {
      QuerySnapshot<Map<String, dynamic>> respons = await storeInstance
          .collection('donating_order')
          .orderBy("date", descending: true)
          .where("name", isEqualTo: search.text.trim())
          .get();
      if (respons.docs.isEmpty) {
        respons = await storeInstance
            .collection('donating_order')
            .orderBy("date", descending: true)
            .where("phone", isEqualTo: search.text.trim())
            .get();
      }
      return respons.docs;
    } catch (e) {
      errorSnackBar("$e");

      return null;
    }
  }
}
