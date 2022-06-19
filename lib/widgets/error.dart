import 'package:flutter/material.dart';

import '../style/text_style.dart';

class ShowError extends StatelessWidget {
  final String error;
  const ShowError({super.key, this.error = 'Error'});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Text(error, style: errorTextStyle),
      ),
    );
  }
}
