class GithubModel {
  String name;
  String url;
  String description;
  String color;
  String lang;
  String fork;
  String stars;
  String starsToday;
  List<String> contributors;
  bool bookmarked;

  GithubModel({
    this.name,
    this.url,
    this.description,
    this.color,
    this.lang,
    this.fork,
    this.stars,
    this.starsToday,
    this.contributors,
    this.bookmarked,
  });

  GithubModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'],
        description = json['description'],
        color = json['color'],
        lang = json['lang'],
        fork = json['fork'],
        stars = json['stars'],
        starsToday = json['starsToday'],
        contributors = json['contributors'].cast<String>(),
        bookmarked = json['bookmarked'];

  static List<GithubModel> parseRepoList(map) {
    var list = map['data'] as List;
    return list.map((repo) => GithubModel.fromJson(repo)).toList();
  }
}
