import 'package:myapp/models/pokemon_serie.dart';
import 'api_client.dart';

class SerieApi {
  final ApiClient _client;

  SerieApi(this._client);

  Future<List<Serie>> getSeriesPerLanguage(String language) async {
    final json = await _client.get("/api/series/language/$language");

    return json.map<Serie>((x) => Serie.fromJson(x)).toList();
  }
}
