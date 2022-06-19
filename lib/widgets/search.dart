import 'package:flutter/material.dart';

import '../style/text_style.dart';
import '../style/colors.dart';
import '../services/api_services/search_joke.dart';
import './error.dart';

class Search extends StatefulWidget {
  static const screenName = '/search';

  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGreen,
      child: Column(
        children: [
          const Center(
            child: Text(
              'Search for a joke',
              style: myTextStyle,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          // width: double.infinity,
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: myController,
                    decoration: const InputDecoration(
                      hintText: 'search joke',
                      fillColor: lightGreenSearch,
                      filled: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
                future: searchJoke(str: myController.text),
                builder: (context, shapshot) {
                  if (shapshot.hasError) {
                    return const ShowError(error: 'Error: something went wrong:(');
                  } else if (shapshot.hasData) {
                    return ListView(
                      children: ((shapshot.data as List<Widget>).isNotEmpty
                          ? shapshot.data as List<Widget>
                          : [
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(10),
                                child: const Text(
                                  'Nothing found!\nRequirments length of search text should be [3, 120]',
                                  style: myTextStyle,
                                ),
                              ),
                            ]),
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
        ],
      ),
    );
  }
}
