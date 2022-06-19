import 'package:flutter/material.dart';

import '../models/joke.dart';
import '../style/button_style.dart';
import '../style/colors.dart';
import './joke_box.dart';
import '../style/text_style.dart';

class FavoriteBox extends StatelessWidget {
  final Joke favoriteJoke;
  const FavoriteBox({super.key, required this.favoriteJoke});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      height: 100,
      margin: const EdgeInsets.only(bottom: 7, top: 7),
      width: double.infinity,
      child: ElevatedButton(
        style: myButtonStyle,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 500,
                  color: customGreen,
                  child: Column(
                    children: [
                      Text(favoriteJoke.categories.join(','),
                          style: myTextStyle),
                      Center(
                        child: JokeBox(joke: favoriteJoke),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Text(
          favoriteJoke.value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
