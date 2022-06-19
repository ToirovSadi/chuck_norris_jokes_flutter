import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../style/text_style.dart';
import '../utils/get_favorites.dart';
import './error.dart';

class Favorites extends StatelessWidget {
  static const scrrenName = '/favorite';

  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: lightGreen,
        width: double.infinity,
        child: Column(children: [
          const Center(
              child: Text(
            'My Favorites Jokes',
            style: myTextStyle,
          )),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
                future: getFavorites(),
                builder: (context, shapshot) {
                  if (shapshot.hasError) {
                    return const ShowError(error: 'Error: something went wrong:(');
                  } else if (shapshot.hasData) {
                    return ListView(
                      children: shapshot.data as List<Widget>,
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: const CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ]));
  }
}
