import 'package:blood_unity_web/core/share/firebase_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../core/share/custom_snakpar.dart';

abstract class AnalyzeDonatingOrderController extends GetxController {
  checkorder();
  updateData();
  calculateBloodType(String bloodType, String rh);
}

class AnalyzeDonatingOrderControllerImp extends AnalyzeDonatingOrderController {
  //obtain order
  List? donatingOrder = [].obs;
  int complatedOrder = 0;
  int newOrder = 0;
  int processingOrder = 0;
  int cancelledOrder = 0;

  //blood type
  int allBloodType = 0;
  int oPtype = 0;
  int aPtype = 0;
  int bPtype = 0;
  int abPtype = 0;

  int oNtype = 0;
  int aNtype = 0;
  int bNtype = 0;
  int abNtype = 0;

  String governorates = "All Governorates";

  @override
  void onInit() async {
    donatingOrder = await getDonatingOrders();
    checkorder();

    super.onInit();
  }

  @override
  checkorder() async {
    if (donatingOrder != null) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> order
          in donatingOrder!) {
        if (order["status"] == "completed") {
          complatedOrder++;
        } else if (order["status"] == "new") {
          newOrder++;
        } else if (order["status"] == "processing") {
          processingOrder++;
        } else {
          cancelledOrder++;
        }
        calculateBloodType(order["bloodtyp"], order["Rh"]);
      }
    }
    update();
  }

  @override
  updateData() async {
    //obtain order
    complatedOrder = 0;
    newOrder = 0;
    processingOrder = 0;
    cancelledOrder = 0;

    //blood type
    allBloodType = 0;
    oPtype = 0;
    aPtype = 0;
    bPtype = 0;
    abPtype = 0;

    oNtype = 0;
    aNtype = 0;
    bNtype = 0;
    abNtype = 0;

    if (governorates != "All Governorates") {
      try {
        QuerySnapshot<Map<String, dynamic>> respons = await FirebaseFirestore
            .instance
            .collection('donating_order')
            .where("governorate", isEqualTo: governorates)
            .get();

        donatingOrder = respons.docs;
        checkorder();
      } catch (e) {
        errorSnackBar(e.toString());
      }
    } else {
      donatingOrder = await getObtainOrders();
      checkorder();
    }
  }

  @override
  calculateBloodType(String bloodType, String rh) {
    allBloodType++;
    if (rh == "Rh+") {
      if (bloodType == "O") {
        oPtype++;
      } else if (bloodType == "A") {
        aPtype++;
      } else if (bloodType == "B") {
        bPtype++;
      } else {
        abPtype++;
      }
    } else {
      if (bloodType == "O") {
        oNtype++;
      } else if (bloodType == "A") {
        aNtype++;
      } else if (bloodType == "B") {
        bNtype++;
      } else {
        abNtype++;
      }
    }
  }
}
