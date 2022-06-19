class Joke {
  List categories;
  String id;
  String url;
  String value;
  Joke({
    required this.id,
    required this.url,
    required this.value,
    this.categories = const [],
  });

  static Joke underfined() {
    return Joke(id: 'null', url: 'null', value: 'Joke not found!');
  }

  static Joke error({error = 'Sorry, something went wrong :('}) {
    return Joke(id: 'error', url: 'error', value: error);
  }

  static Joke fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json["id"],
      url: json["url"],
      value: json["value"],
      categories: json["categories"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'value': value,
      'categories': categories,
    };
  }
}
