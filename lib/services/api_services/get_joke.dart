import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/joke.dart';
import '../../constants/constants.dart';

Future<Joke> getNewJoke({categories = const []}) async {
  String? mergedCategories = _mergeCategories(categories);
  // print('mergedCategories: $mergedCategories');
  if (mergedCategories == null) {
    return Joke.underfined();
  } else {
    Joke recievedJoke = Joke.underfined();
    recievedJoke = await _getJoke(mergedCategories)
        .then((value) => value)
        .catchError((error, stackTrace) {
      // print(
          // 'error: lib/services/api_services/get_joke.dart:getNewJoke(): $error');
      return Joke.error();
    });
    return recievedJoke;
  }
}

String? _mergeCategories(List categories) {
  if (!categories
      .every((element) => categoryList.contains(element as String))) {
    // print(
        // 'error: lib/services/api_services/get_joke.dart(_mergeCategories): no such categories found: $categories');
    // print('expected one of: $categoryList');
    // print('provided categories: $categories');
    return null;
  }
  return categories.join(',');
}

Future<Joke> _getJoke(String categories) async {
  // print(
  //     'url: $apiUrl/jokes/random${categories.isNotEmpty ? '?category=$categories' : ''}');
  return await http
      .get(Uri.parse(
          '$apiUrl/jokes/random${categories.isNotEmpty ? '?category=$categories' : ''}'))
      .then((response) {
    if (response.statusCode == 200) {
      // print('body: ${response.body}');
      // print(
      //     'joke: ${(Joke.fromJson(jsonDecode(response.body) as Map<String, dynamic>)).categories}');
      return Joke.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // print(
      //     'error[${response.statusCode}]: lib/services/api_services/get_joke.dart: ${response.body}');
      return Joke.error();
    }
  }).onError((error, stackTrace) {
    // print('error: lib/services/api_services/get_joke.dart(_getJoke): $error');
    return Joke.error();
  });
}
