import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant/app_routes.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return RouteSettings(name: AppRoutes.homePage);
    }
    return null;
  }
}
