import 'package:flutter/material.dart';

import 'add_event.dart';
import 'news.dart';

class Event extends StatelessWidget {
  const Event({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
        width: width > 600 ? width * 0.90 : 600,
        child: width > 1000
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: width * 0.35,
                    child: const AddEvent(),
                  ),
                  SizedBox(
                    width: width * 0.50,
                    child: const News(),
                  )
                ],
              )
            : const News());
  }
}
