import 'package:blood_unity_web/screen/homePage/widget/List_article.dart';
import 'package:flutter/material.dart';

import 'add_article.dart';

class Article extends StatelessWidget {
  const Article({super.key});

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
                    child: const AddArticle(),
                  ),
                  SizedBox(
                    width: width * 0.50,
                    child: const ListArticle(),
                  )
                ],
              )
            : const ListArticle());
  }
}
