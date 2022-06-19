import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/app_bar.dart';
import '../style/button_style.dart';
import '../widgets/category_name.dart';
import '../widgets/joke_box.dart';
import '../models/joke.dart';
import '../services/api_services/get_joke.dart';
import '../models/navigator_argumets.dart';

class JokeViewScreen extends StatefulWidget {
  static const scrrenName = '/joke_view';

  const JokeViewScreen({super.key});

  @override
  State<JokeViewScreen> createState() => _JokeViewScreenState();
}

class _JokeViewScreenState extends State<JokeViewScreen> {
  IconData favoriteIcon = Icons.favorite_border;
  Joke? currentJoke = Joke.underfined();
  bool _change = false;
  bool _init = true;
  bool enablePrevButton = false;
  List<Joke> previewedJoke = [Joke.underfined()];
  CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');

  previousJoke() {
    setState(() {
      currentJoke = previewedJoke.last;
      if (previewedJoke.length <= 3) {
        enablePrevButton = false;
      }
      favoriteIcon = Icons.favorite_border;
    });
    previewedJoke.removeLast();
  }

  void init(BuildContext context) {
    if (!_init) return;
    final args = (ModalRoute.of(context)?.settings.arguments ??
        NavigatorArgumets()) as NavigatorArgumets;
    currentJoke?.categories = args.categories;
    _change = true;
    listenAndAccept();
    if (currentJoke != null) {
      previewedJoke.add(currentJoke!);
    }
    _init = false;
  }

  void addToFavorite(Joke? joke) {
    if (joke == null) return;

    if (favoriteIcon == Icons.favorite_border) {
      favorites.add(joke.toJson()).then((value) {
        // print('this joke added to favorites!');
        setState(() {
          favoriteIcon = Icons.favorite;
        });
      }); //.catchError((error) => print("Failed to add to favorites: $error"));
    } else {
      favorites.get().then((value) {
        for (var doc in value.docs) {
          if (doc.get('id') == joke.id) {
            doc.reference.delete().then((value) {
              // print('this joke deletd from favorites!: $doc');
              setState(() {
                favoriteIcon = Icons.favorite_border;
              });
            });
          }
        }
      }); //.catchError((error) => print("Failed to delete favorite: $error"));
    }
  }

  Future<Joke> listenAndAccept() async {
    if (!_change) return Joke.underfined();
    // print('listenAndAccept: ${currentJoke?.categories}');
    var response = await getNewJoke(categories: currentJoke?.categories)
        .then((value) => currentJoke = value);
    _change = false;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return Scaffold(
      appBar: getAppBar(
        title: const Text('Joke Viewer'),
      ),
      body: Column(
        children: [
          CategoryName(
            categories: NavigatorArgumets(
              categories: currentJoke?.categories ?? [],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
              future: listenAndAccept(),
              builder: (context, shapshot) {
                if (shapshot.hasError) {
                  return JokeBox(joke: Joke.error());
                } else if (shapshot.hasData &&
                    shapshot.data != Joke.underfined()) {
                  return JokeBox(joke: currentJoke as Joke);
                } else {
                  return Container(
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    child: const CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: enablePrevButton ? previousJoke : null,
                style: navigationButtonStyle,
                child: const Icon(Icons.arrow_back),
              ),
              ElevatedButton(
                onPressed: () {
                  addToFavorite(currentJoke);
                },
                style: navigationButtonStyle,
                child: Icon(favoriteIcon),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _change = true;
                    if (currentJoke != null) {
                      previewedJoke.add(currentJoke!);
                      if (previewedJoke.length > 2) {
                        enablePrevButton = true;
                      }
                    }
                    favoriteIcon = Icons.favorite_border;
                  });
                },
                style: navigationButtonStyle,
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
