import 'package:myapp/models/pokemon_card.dart';
import 'package:myapp/api/card_api.dart';

class CardService {
  final CardApi _api;

  final Map<String, List<Card>> _cards = {};
  final Map<String, Future<List<Card>>> _loading = {};

  CardService(this._api);

  void clearCache() {
    _cards.clear();
  }

  Future<List<Card>> getCardsPerSet(String setId, int? userId) async {
    if (_cards.containsKey(setId)) {
      return _cards[setId]!;
    }

    if (_loading.containsKey(setId)) {
      return _loading[setId]!;
    }

    final future = _api.getCardsPerSet(setId, userId);

    _loading[setId] = future;

    final result = await future;

    _cards[setId] = result;
    _loading.remove(setId);

    return result;
  }

  Future updateUserCards(int? userId, List<Card> cards) async {
    if (userId == null) return;

    final changedCards = cards.where((card) => card.changed).toList();
    final userCards = changedCards.map((card) {
      return UserCard(
        userId: userId,
        cardId: card.id,
        inCollection: card.inCollection,
        favorite: card.favorite,
        wanted: card.wanted,
      );
    }).toList();

    final future = _api.updateUserCards(userId, userCards);

    for (var card in changedCards) {
      card.changed = false;
    }

    return;
  }
}
