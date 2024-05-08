import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Auth/signin_page_controller.dart';
import '../../../core/share/background.dart';
import 'widget/or_divider.dart';
import 'widget/other_account.dart';
import 'widget/phone_password_container.dart';
import 'widget/signup_row.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignInControllerImp());
    double hight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Background(
            title: "Sign In".tr,
            text: "Please Sign In to continue".tr,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: hight * 0.25,
                ),
                const EmailPasswordContainer(),
                const ORDivider(),
                const OtherAccount(),
                const SignUpRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
