import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl = "http://37.120.165.143:8080";

  final http.Client _client = http.Client();

  Future<dynamic> get(String endpoint) async {
    final response = await _client.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: {"Content-Type": "application/json"},
    );

    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic body) async {
    final response = await _client.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, dynamic body) async {
    final response = await _client.put(
      Uri.parse("$baseUrl$endpoint"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }

    throw Exception("API error ${response.statusCode}: ${response.body}");
  }
}
