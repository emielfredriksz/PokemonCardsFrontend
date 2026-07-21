import 'package:flutter/material.dart';
import 'package:myapp/services/set_service.dart';
import 'package:provider/provider.dart';
import 'package:myapp/screens/homepage.dart';
import 'package:myapp/state/app_state.dart';
import 'package:myapp/api/api_client.dart';
import 'package:myapp/api/serie_api.dart';
import 'package:myapp/services/serie_service.dart';
import 'package:myapp/api/set_api.dart';
import 'package:myapp/services/set_service.dart';
import 'package:myapp/api/card_api.dart';
import 'package:myapp/services/card_service.dart';
import 'package:myapp/screens/serie_page.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/api/auth_api.dart';

import 'dart:io';

void main() {
  final apiClient = ApiClient();

  final serieApi = SerieApi(apiClient);
  final serieService = SerieService(serieApi);
  final setApi = SerieApi(apiClient);
  final setService = SerieService(setApi);
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        Provider(create: (_) => SerieApi(apiClient)),

        ProxyProvider<SerieApi, SerieService>(
          update: (_, serieApi, __) => SerieService(serieApi),
        ),

        Provider(create: (_) => SetApi(apiClient)),
        ProxyProvider<SetApi, SetService>(
          update: (_, setApi, __) => SetService(setApi),
        ),

        Provider(create: (_) => CardApi(apiClient)),
        ProxyProvider<CardApi, CardService>(
          update: (_, cardApi, __) => CardService(cardApi),
        ),

        Provider(create: (_) => AuthApi(apiClient)),
        ProxyProvider<AuthApi, AuthService>(
          update: (_, authApi, __) => AuthService(authApi),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Image Loader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      home: const SeriePage(title: 'Pokemon Series'),
    );
  }
}
