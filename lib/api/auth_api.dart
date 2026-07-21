import 'package:myapp/models/auth.dart';
import 'api_client.dart';

class AuthApi {
  final ApiClient _client;

  AuthApi(this._client);

  Future<int?> login(UserAuth userAuth) async {
    final response = await _client.post("/api/auth/login", userAuth);

    return response as int?;
  }

  Future register(UserAuth userAuth) async {
    final response = await _client.post("/api/auth/register", userAuth);

    return;
  }
}
