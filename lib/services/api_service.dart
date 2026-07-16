import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/pokemon_serie.dart';
import 'package:myapp/models/pokemon_set.dart';
import 'package:myapp/models/pokemon_card.dart';

class ApiService {
  static const String baseUrl = "http://37.120.165.143:8080/api";
  //static const String baseUrl = "https://localhost:52679/api";

  final Map<String, List<PokemonSet>> _sets = {};
  final Map<String, List<PokemonCard>> _cards = {};

  Future<List<PokemonCard>> getCardsPerSet(String setId) async {
    if (_cards.containsKey(setId)) {
      return _cards[setId]!;
    }

    final response = await http.get(Uri.parse("$baseUrl/cards/setId/$setId"));

    if (response.statusCode == 200) {
      List<dynamic> jsonArray = jsonDecode(response.body);
      final cards = jsonArray
          .map((json) => PokemonCard.fromJson(json))
          .toList();
      _cards[setId] = cards;
      return cards;
    } else {
      throw Exception("Failed to load cards");
    }
  }

  Future<List<PokemonSet>> getSetsPerSerie(String serieId) async {
    if (_sets.containsKey(serieId)) {
      return _sets[serieId]!;
    }

    final response = await http.get(
      Uri.parse("$baseUrl/cards/setId/$serieId"),
    ); // make endpoint

    if (response.statusCode == 200) {
      List<dynamic> jsonArray = jsonDecode(response.body);
      final sets = jsonArray.map((json) => PokemonSet.fromJson(json)).toList();
      _sets[serieId] = sets;
      return sets;
    } else {
      throw Exception("Failed to load cards");
    }
  }
}
