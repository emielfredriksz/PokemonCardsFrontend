class Card {
  final String id;
  final String name;
  final String localId;
  final String? imageUrl;
  bool inCollection;
  bool wanted;
  bool favorite;

  bool changed = false;

  Card({
    required this.id,
    required this.name,
    required this.localId,
    required this.imageUrl,
    required this.inCollection,
    required this.wanted,
    required this.favorite,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json["id"],
      name: json["name"],
      localId: json["localId"],
      imageUrl: json["image"] != null ? "${json["image"]}/low.webp" : null,
      inCollection: json["inCollection"],
      wanted: json["wanted"],
      favorite: json["favorite"],
    );
  }
}

int compareCardIds(Card a, Card b) {
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

class UserCard {
  final String cardId;
  final int userId;
  bool? inCollection;
  bool? wanted;
  bool? favorite;

  UserCard({
    required this.cardId,
    required this.userId,
    required this.inCollection,
    required this.wanted,
    required this.favorite,
  });

  Map<String, dynamic> toJson() {
    return {
      "cardId": cardId,
      "userId": userId,
      "inCollection": inCollection,
      "wanted": wanted,
      "favorite": favorite,
    };
  }
}
