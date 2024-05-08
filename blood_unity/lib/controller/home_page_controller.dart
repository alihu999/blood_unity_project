import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../core/services/services.dart';

abstract class HomePageController extends GetxController {
  Future getNews();
}

class HomePageControllerImp extends HomePageController {
  MyServices myServices = Get.find();
  String? sharedPrefLang;

  FirebaseFirestore storeInstance = FirebaseFirestore.instance;

  @override
  void onInit() {
    sharedPrefLang = myServices.sharedPreferences.getString("lang");
    super.onInit();
  }

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> getNews() async {
    try {
      QuerySnapshot<Map<String, dynamic>> respons =
          await storeInstance.collection('news').get();
      return respons.docs;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
