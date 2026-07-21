import 'package:flutter/material.dart';
import 'package:myapp/api/api_client.dart';
import 'package:myapp/api/serie_api.dart';
import 'package:myapp/services/serie_service.dart';

class AppState extends ChangeNotifier {
  int? userId;
  String language = "en";

  void setUserId(int? id) {
    userId = id;
    notifyListeners();
  }

  void setLanguage(String value) {
    language = value;
    notifyListeners();
  }
}
