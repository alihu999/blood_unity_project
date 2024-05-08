import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ORDivider extends StatelessWidget {
  const ORDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      width: 370,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
              flex: 1,
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              )),
          Expanded(
              flex: 1,
              child: Text(
                "or continue with".tr,
                textAlign: TextAlign.center,
              )),
          const Expanded(
              flex: 1,
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              )),
        ],
      ),
    );
  }
}
