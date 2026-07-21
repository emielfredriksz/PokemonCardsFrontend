class Set {
  final String id;
  final String serieId;
  final String name;
  final String? logo;
  final String? symbol;
  final DateTime releaseDate;
  final int totalCardCount;
  final int officialCardCount;
  final int secretCardCount;

  Set({
    required this.id,
    required this.serieId,
    required this.name,
    required this.logo,
    required this.symbol,
    required this.releaseDate,
    required this.totalCardCount,
    required this.officialCardCount,
    required this.secretCardCount,
  });

  factory Set.fromJson(Map<String, dynamic> json) {
    return (Set(
      id: json["id"],
      serieId: json["serieId"],
      name: json["name"],
      logo: json["logo"] != null ? "${json["logo"]}.webp" : null,
      symbol: json["symbol"] != null ? "${json["symbol"]}.webp" : null,
      releaseDate: DateTime.parse(json["releaseDate"]),
      totalCardCount: json["totalCardCount"],
      officialCardCount: json["officialCardCount"],
      secretCardCount: json["secretCardCount"],
    ));
  }
}

int compareSets(Set a, Set b) {
  return a.releaseDate.compareTo(b.releaseDate);
}
