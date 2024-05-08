import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class Background extends StatelessWidget {
  final String title, text;
  const Background({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            height: hight,
            width: width,
            color: AppColors.primaryColor,
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text(
                  text,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double hight = size.height;

    final path = Path();
    path.lineTo(0, hight * 0.20);
    path.quadraticBezierTo(width * 0.80, hight * 0.25, width, hight * 0.6);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
