import 'package:flutter/material.dart';

import '../constant/app_colors.dart';

class CustomBox extends StatelessWidget {
  final String title;
  final String number;
  final String percentage;
  const CustomBox(
      {super.key,
      required this.title,
      required this.number,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: AppColors.primaryColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(title), Text(number), Text(percentage)],
      ),
    );
  }
}
