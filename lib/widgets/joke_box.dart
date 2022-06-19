import 'package:chuck_norries_jokes/style/text_style.dart';
import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../models/joke.dart';

class JokeBox extends StatelessWidget {
  final Joke joke;
  const JokeBox({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: customGreen,
      ),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      // color: customGreen,
      child: Text(
        joke.value,
        style: jokeTextStyle,
      ),
    );
  }
}
