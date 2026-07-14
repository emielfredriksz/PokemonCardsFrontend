class PokemonCard {
  final String id;
  final String name;
  final String localId;
  final String imageUrl;

  PokemonCard({
    required this.id,
    required this.name,
    required this.localId,
    required this.imageUrl,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json["id"],
      name: json["name"],
      localId: json["localId"],
      imageUrl: json["image"] + "/high.jpg",
    );
  }
}

int compareCardIds(PokemonCard a, PokemonCard b) {
  final aId = int.tryParse(a.localId);
  final bId = int.tryParse(b.localId);

  if (aId == null && bId == null) {
    return a.localId.compareTo(b.localId);
  }
  if (aId == null && bId != null) {
    return -1;
  }
  if (aId != null && bId == null) {
    return 1;
  }
  if (aId! < bId!) return -1;
  return 1;
}
