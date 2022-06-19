import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/joke.dart';
import '../../constants/constants.dart';
import '../../widgets/favorite_box.dart';

Future<List<Widget>> searchJoke({String str = ''}) async {
  List<Widget> result = [];
  if (str.length < 3) return result;
  await _search(str).then((value) {
    for (final joke in value) {
      result.add(FavoriteBox(
        favoriteJoke: joke,
      ));
    }
  }).catchError((error) {
    // print(
    //     'error: lib/services/api_services/search_joke.dart(searchJoke): $error');
  });

  return result;
}

Future<List<Joke>> _search(String str) async {
  // print('str: $str');
  // print('url: $apiUrl/jokes/search${str.isNotEmpty ? '?query=$str' : ''}');
  return await http
      .get(Uri.parse(
          '$apiUrl/jokes/search${str.isNotEmpty ? '?query=$str' : ''}'))
      .then((response) {
    List<Joke> result = [];
    if (response.statusCode == 200) {
      // print(
      //     'joke: ${(Joke.fromJson(jsonDecode(response.body) as Map<String, dynamic>)).categories}');
      for (final joke
          in (jsonDecode(response.body) as Map<String, dynamic>)['result']) {
        result.add(Joke(
          id: joke['id'] as String,
          url: joke['url'] as String,
          value: joke['value'] as String,
          categories: joke['categories'] as List,
        ));
      }
    } else {
      // print(
      //     'error[${response.statusCode}]: lib/services/api_services/search_joke.dart: ${response.body}');
    }
    return result;
  }).catchError((error) {
    // print('error: lib/services/api_services/search_joke.dart(_search): $error');
    return <Joke>[];
  });
}
