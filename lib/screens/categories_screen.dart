import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../constants/constants.dart';
import '../style/text_style.dart';
import '../style/colors.dart';
import '../models/navigator_argumets.dart';

class CategoriesScreen extends StatelessWidget {
  static const screenName = '/categories';

  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: const Text('Categories')),
      body: Container(
        width: double.infinity,
        color: lightGreen,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              runSpacing: 17,
              spacing: 17,
              children: [
                ...categoryList.map((e) {
                  if (e.length < 2) {
                    return const Text(
                      'Invalid category',
                      style: errorTextStyle,
                    );
                  }
                  String originalElement = e;
                  e = e[0].toUpperCase() + e.substring(1);
                  return Container(
                    width: 161,
                    height: 114,
                    color: customGreen,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/joke_view',
                          arguments:
                              NavigatorArgumets(categories: [originalElement]),
                        );
                      },
                      child: Center(
                        child: Text(e, style: textCategoriesStyle),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
