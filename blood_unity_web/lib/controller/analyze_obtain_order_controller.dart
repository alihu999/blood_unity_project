import 'package:blood_unity_web/core/share/custom_snakpar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../core/share/firebase_function.dart';

abstract class AnalyzeObtainOrderController extends GetxController {
  checkorder();
  updateData();
}

class AnalyzeObtainOrderControllerImp extends AnalyzeObtainOrderController {
  //obtain order
  List? obtainOrder = [].obs;
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
    obtainOrder = await getObtainOrders();
    checkorder();
    super.onInit();
  }

  @override
  checkorder() async {
    if (obtainOrder != null) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> order in obtainOrder!) {
        if (order["status"] == "completed") {
          complatedOrder++;
        } else if (order["status"] == "new") {
          newOrder++;
        } else if (order["status"] == "processing") {
          processingOrder++;
        } else {
          cancelledOrder++;
        }

        calculateBloodType(order["bloodtyp"]);
      }
    }
    update();
  }

  calculateBloodType(List typeList) {
    for (String type in typeList) {
      allBloodType++;
      if (type == "O+") {
        oPtype++;
      } else if (type == "O-") {
        oNtype++;
      } else if (type == "A+") {
        aPtype++;
      } else if (type == "A-") {
        aNtype++;
      } else if (type == "B+") {
        bPtype++;
      } else if (type == "B-") {
        bNtype++;
      } else if (type == "AB+") {
        abPtype++;
      } else if (type == "AB-") {
        abNtype++;
      }
    }
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
            .collection('obtain_order')
            .where("governorate", isEqualTo: governorates)
            .get();

        obtainOrder = respons.docs;
        checkorder();
      } catch (e) {
        errorSnackBar(e.toString());
      }
    } else {
      obtainOrder = await getObtainOrders();
      checkorder();
    }
  }
}
