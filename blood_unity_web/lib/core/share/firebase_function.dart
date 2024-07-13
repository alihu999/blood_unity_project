import 'package:cloud_firestore/cloud_firestore.dart';

import 'custom_snakpar.dart';

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
    getObtainOrders() async {
  try {
    QuerySnapshot<Map<String, dynamic>> respons = await FirebaseFirestore
        .instance
        .collection('obtain_order')
        .orderBy("date", descending: true)
        .get();
    return respons.docs;
  } catch (e) {
    errorSnackBar("$e");
    return null;
  }
}

@override
Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
    getDonatingOrders() async {
  try {
    QuerySnapshot<Map<String, dynamic>> respons = await FirebaseFirestore
        .instance
        .collection('donating_order')
        .orderBy("date", descending: true)
        .get();
    return respons.docs;
  } catch (e) {
    errorSnackBar("$e");
    return null;
  }
}
