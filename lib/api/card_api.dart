import 'package:myapp/models/pokemon_card.dart';
import 'api_client.dart';

class CardApi {
  final ApiClient _client;

  CardApi(this._client);

  Future<List<Card>> getCardsPerSet(String setId, int? userId) async {
    final json = userId != null
        ? await _client.get("/api/cards/setId/$setId?userId=$userId")
        : await _client.get("/api/cards/setId/$setId");

    return json.map<Card>((x) => Card.fromJson(x)).toList();
  }

  Future updateUserCards(int? userId, List<UserCard> usercards) async {
    final json = await _client.put("/api/cards/", usercards);

    return;
  }
}
