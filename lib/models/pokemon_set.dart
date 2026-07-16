class PokemonSet {
  final String id;
  final String name;
  final String localId;
  final String imageUrl;

  PokemonSet({
    required this.id,
    required this.name,
    required this.localId,
    required this.imageUrl,
  });

  factory PokemonSet.fromJson(Map<String, dynamic> json) {
    return PokemonSet(
      id: json["id"],
      name: json["name"],
      localId: json["localId"],
      imageUrl: json["image"] + "/high.jpg",
    );
  }
}

int compareCardIds(PokemonSet a, PokemonSet b) {
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
