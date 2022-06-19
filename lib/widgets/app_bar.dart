import 'package:flutter/material.dart';

import '../style/colors.dart';

AppBar getAppBar({
  title = const Text('Chuck Norris Jokes'),
  backgroundColor = customGreen,
  elevation = 0.0,
}) {
  return AppBar(
    title: title,
    backgroundColor: backgroundColor,
    elevation: elevation,
  );
}
