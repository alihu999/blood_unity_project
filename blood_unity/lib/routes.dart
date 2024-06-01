import 'package:blood_unity/core/middaleware/my_middleware.dart';

import 'package:blood_unity/screen/obtain/obtain.dart';
import 'package:get/get.dart';

import 'core/constant/app_routes.dart';
import 'screen/auth/signup_page/signup_page.dart';
import 'screen/auth/signin_page/signin_page.dart';
import 'screen/donating/donating.dart';
import 'screen/home_page/home_page.dart';
import 'screen/select_languge.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
      name: "/",
      page: () => const SelectLanguge(),
      middlewares: [MyMiddleware()]),
  GetPage(name: AppRoutes.signUp, page: () => const SignUpPage()),
  GetPage(name: AppRoutes.signIn, page: () => const SignInPage()),
  GetPage(name: AppRoutes.homePage, page: () => const HomePage()),
  GetPage(name: AppRoutes.donatingPage, page: () => const DonatingPage()),
  GetPage(name: AppRoutes.obtainPage, page: () => const ObtainPage()),
];
