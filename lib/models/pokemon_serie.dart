class Serie {
  final String id;
  final String name;
  final String? logo;
  final String language;
  final DateTime releaseDate;

  Serie({
    required this.id,
    required this.name,
    required this.logo,
    required this.language,
    required this.releaseDate,
  });

  factory Serie.fromJson(Map<String, dynamic> json) {
    return Serie(
      id: json["id"],
      name: json["name"],
      logo: json["logo"] != null ? "${json["logo"]}.webp" : null,
      language: json["language"],
      releaseDate: DateTime.parse(json["releaseDate"]),
    );
  }
}

int compareSeries(Serie a, Serie b) {
  return a.releaseDate.compareTo(b.releaseDate);
}
