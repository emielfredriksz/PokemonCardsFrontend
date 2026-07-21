import 'package:myapp/models/pokemon_set.dart';
import 'package:myapp/api/set_api.dart';

class SetService {
  final SetApi _api;

  final Map<String, List<Set>> _sets = {};
  final Map<String, Future<List<Set>>> _loading = {};

  SetService(this._api);

  Future<List<Set>> getSetsPerSerie(String serieId) async {
    if (_sets.containsKey(serieId)) {
      return _sets[serieId]!;
    }

    if (_loading.containsKey(serieId)) {
      return _loading[serieId]!;
    }

    final future = _api.getSetsPerSerie(serieId);

    _loading[serieId] = future;

    final result = await future;

    _sets[serieId] = result;
    _loading.remove(serieId);

    return result;
  }
}
