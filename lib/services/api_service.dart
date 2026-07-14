import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/pokemon_card.dart';

class ApiService {
  //static const String baseUrl = "https://10.0.2.2:52679/api";
  static const String baseUrl = "https://localhost:52679/api";

  Future<List<PokemonCard>> getCards() async {
    final response = await http.get(Uri.parse("$baseUrl/cards/setId/base1"));

    if (response.statusCode == 200) {
      List<dynamic> jsonArray = jsonDecode(response.body);

      return jsonArray.map((json) => PokemonCard.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load cards");
    }
  }
}
