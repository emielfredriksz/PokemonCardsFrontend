import 'package:myapp/models/pokemon_serie.dart';
import 'package:myapp/api/serie_api.dart';

class SerieService {
  final SerieApi _api;

  final Map<String, List<Serie>> _series = {};
  final Map<String, Future<List<Serie>>> _loading = {};

  SerieService(this._api);

  Future<List<Serie>> getSeriesPerLanguage(String language) async {
    if (_series.containsKey(language)) {
      return _series[language]!;
    }

    if (_loading.containsKey(language)) {
      return _loading[language]!;
    }

    final future = _api.getSeriesPerLanguage(language);

    _loading[language] = future;

    final result = await future;

    _series[language] = result;
    _loading.remove(language);

    return result;
  }
}
