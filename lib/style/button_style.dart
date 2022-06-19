import 'package:flutter/material.dart';

import './colors.dart';
import './text_style.dart';

final ButtonStyle myButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(200, 54),
  primary: customGreen,
  textStyle: myTextStyle,
);

final ButtonStyle navigationButtonStyle = ElevatedButton.styleFrom(
  shape: const CircleBorder(),
  minimumSize: const Size(58, 58),
  primary: customGreen,
);
