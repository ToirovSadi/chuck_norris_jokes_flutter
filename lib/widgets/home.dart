import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../style/button_style.dart';
import '../models/navigator_argumets.dart';
import '../style/text_style.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGreen,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/chucknorris_logo.png',
                errorBuilder: (context, error, stackTrace) =>
                    const Text('couldn\'t load logo!', style: errorTextStyle),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 256,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/joke_view');
                    },
                    style: myButtonStyle,
                    child: const Center(
                      child: Text('Random Joke'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/categories',
                        arguments: NavigatorArgumets,
                      );
                    },
                    style: myButtonStyle,
                    child: const Center(
                      child: Text('Categories'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
