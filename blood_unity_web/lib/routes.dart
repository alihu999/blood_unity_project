import 'package:blood_unity_web/core/constant/app_route.dart';
import 'package:blood_unity_web/screen/analyze_donating_order/analyze_donating_order.dart';
import 'package:blood_unity_web/screen/analyze_obtain_order/analyze_obtain_order.dart';
import 'package:blood_unity_web/screen/homePage/home_page.dart';
import 'package:blood_unity_web/screen/login_page/login_page.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: "/", page: () => const HomePage()),
  GetPage(
      name: AppRoutes.analyzeObtainOrder,
      page: () => const AnalyzeObtainOrder()),
  GetPage(
      name: AppRoutes.analyzeDonatingOrder,
      page: () => const AnalyzeDonatingOrder()),
  GetPage(name: AppRoutes.loginPage, page: () => const LoginPage())
];
