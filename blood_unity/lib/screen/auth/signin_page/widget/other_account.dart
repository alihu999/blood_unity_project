import 'package:blood_unity/controller/Auth/signin_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/image_assets.dart';

class OtherAccount extends GetView<SignInControllerImp> {
  const OtherAccount({super.key});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              controller.signInWithGoogle();
            },
            child: Image.asset(
              ImageAssets.google,
              height: hight * 0.065,
            ),
          ),
          InkWell(
            onTap: () {
              controller.signInWithFacebook();
            },
            child: Image.asset(
              ImageAssets.facebook,
              height: hight * 0.065,
            ),
          ),
          Image.asset(
            ImageAssets.apple,
            height: hight * 0.065,
          )
        ],
      ),
    );
  }
}
