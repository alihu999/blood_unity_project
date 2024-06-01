import 'package:blood_unity/core/constant/blood_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../core/constant/app_routes.dart';
import '../core/share/custom_snakbar.dart';

class OrderController extends GetxController {
  FirebaseFirestore storeInstance = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser!;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      getOrderOptin() async {
    try {
      QuerySnapshot<Map<String, dynamic>> respons = await storeInstance
          .collection('obtain_order')
          .where('uid', isEqualTo: user.uid)
          .get();
      return respons.docs;
    } catch (e) {
      errorSnackBar("$e");
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      getOrderDonating() async {
    try {
      QuerySnapshot<Map<String, dynamic>> respons = await storeInstance
          .collection('donating_order')
          .where('uid', isEqualTo: user.uid)
          .get();
      return respons.docs;
    } catch (e) {
      errorSnackBar("$e");
      return null;
    }
  }

  updateOptain(String name, String phone, String healthStatus, String number,
      String governorate, List bloodType, String id) {
    Get.toNamed(AppRoutes.obtainPage, arguments: {
      "firstName": name.substring(0, name.indexOf(" ")),
      "lastName": name.substring(name.indexOf(" ") + 1),
      "phone": phone,
      "status": healthStatus,
      "numberUnits": number,
      "bloodtypeN": bloodGropN.toSet().intersection(bloodType.toSet()),
      "bloodtypeP": bloodGropP.toSet().intersection(bloodType.toSet()),
      "governorate": governorate,
      "id": id
    });
  }

  updateDonating(String name, String phone, String malady, String governorate,
      String bloodType, String rh, String id) {
    Get.toNamed(AppRoutes.donatingPage, arguments: {
      "firstName": name.substring(0, name.indexOf(" ")),
      "lastName": name.substring(name.indexOf(" ") + 1),
      "phone": phone,
      "malady": malady,
      "governorate": governorate,
      "bloodType": bloodType,
      "Rh": rh,
      "id": id
    });
  }
}
