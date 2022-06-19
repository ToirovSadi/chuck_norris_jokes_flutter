import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/favorite_box.dart';
import '../models/joke.dart';

Future<List<Widget>> getFavorites() async {
  CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');
  List<Widget> favoritesList = [];
  await favorites.get().then((data) {
    for (final favorite in data.docs) {
      var joke = Joke(
        id: favorite.get('id'),
        url: favorite.get('url'),
        value: favorite.get('value'),
        categories: favorite.get('categories') as List,
      );
      favoritesList.add(FavoriteBox(
        favoriteJoke: joke,
      ));
    }
  });
  // .catchError((error) => print("Failed to fetch favorites: $error"))
  // .whenComplete(() => print('done'));

  return favoritesList;
}
