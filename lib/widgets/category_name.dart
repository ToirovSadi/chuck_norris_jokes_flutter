import 'package:flutter/material.dart';

import '../models/navigator_argumets.dart';
import '../style/text_style.dart';

class CategoryName extends StatelessWidget {
  final NavigatorArgumets categories;
  const CategoryName({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Category: ${(categories.categories.isEmpty ? 'Random' : categories.categories.join(','))}',
      style: textCategoriesStyle,
    );
  }
}
