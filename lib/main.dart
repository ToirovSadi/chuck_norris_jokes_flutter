import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

const _baseUrl = 'https://api.chucknorris.io';

Future<Map<String, Object?>> _fetchJokeJson() async {
  final response = await get(Uri.parse('$_baseUrl/jokes/random'));
  return jsonDecode(response.body) as Map<String, Object?>;
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Chuck Norris Jokes',
      // darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _aboutInfo =
      'This is app of Chuck Norris Jokes\nEnjoy!\nApp was created by Sadi Toirov\nThis app using API';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Norris Jokes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
              border: Border.all(width: 3),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(
              _aboutInfo,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Jokes()),
              );
            },
            child: const Text('Jokes'),
          )
        ],
      ),
    );
  }
}

class Jokes extends StatefulWidget {
  const Jokes({Key? key}) : super(key: key);

  @override
  State<Jokes> createState() => _JokesState();
}

class _JokesState extends State<Jokes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Norris Jokes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: const _JsonWidget(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Icon(Icons.home),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Jokes()),
                      );
                    },
                    child: const Icon(Icons.arrow_forward),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _JsonWidget extends StatelessWidget {
  const _JsonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, Object?>>(
        future: _fetchJokeJson(),
        builder: (context, snapshot) {
          final data = snapshot.data?['value'];
          if (data == null) {
            return const CircularProgressIndicator();
          }
          return Text(data.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontFamily: 'Verdana',
                fontWeight: FontWeight.bold,
              ));
        });
  }
}
