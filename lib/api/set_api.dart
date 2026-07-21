import 'package:myapp/models/pokemon_set.dart';
import 'api_client.dart';

class SetApi {
  final ApiClient _client;

  SetApi(this._client);

  Future<List<Set>> getSetsPerSerie(String serieId) async {
    final json = await _client.get("/api/sets/serieId/$serieId");

    return json.map<Set>((x) => Set.fromJson(x)).toList();
  }
}
