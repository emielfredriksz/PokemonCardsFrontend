import 'package:myapp/models/auth.dart';
import 'package:myapp/api/auth_api.dart';

class AuthService {
  final AuthApi _api;

  AuthService(this._api);

  Future<int?> login(String username, String password) async {
    UserAuth userAuth = new UserAuth(username: (username), password: password);
    final result = _api.login(userAuth);

    return result;
  }

  Future register(String username, String password) async {
    UserAuth userAuth = new UserAuth(username: (username), password: password);
    final result = _api.register(userAuth);

    return result;
  }
}
