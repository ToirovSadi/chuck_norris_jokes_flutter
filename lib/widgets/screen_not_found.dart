import 'package:flutter/material.dart';

class ScreenNotFound extends StatelessWidget {
  const ScreenNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Page Not Found!',
        style: TextStyle(
          fontSize: 30,
          color: Colors.red,
        ),
      ),
    );
  }
}
