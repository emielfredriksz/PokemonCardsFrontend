import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myapp/models/pokemon_serie.dart';
import 'package:myapp/screens/login_page.dart';
import 'package:myapp/state/app_state.dart';
import 'package:myapp/widgets/tab_button.dart';
import 'package:myapp/models/pokemon_card.dart';
import '../services/serie_service.dart';
import 'package:provider/provider.dart';
import 'package:myapp/screens/set_page.dart';
import 'package:myapp/widgets/serie_container.dart';

class SeriePage extends StatefulWidget {
  const SeriePage({super.key, required this.title});

  final String title;

  @override
  State<SeriePage> createState() => _SeriePageState();
}

class _SeriePageState extends State<SeriePage> {
  late Future<List<Serie>> series;

  @override
  void initState() {
    super.initState();

    final service = context.read<SerieService>();
    series = service.getSeriesPerLanguage(context.read<AppState>().language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // LEFT SIDEBAR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              TabButton(
                label: "Login",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(isRegister: false),
                    ),
                  );
                },
              ),
              TabButton(
                label: "Register",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(isRegister: true),
                    ),
                  );
                },
              ),
              TabButton(
                label: "Needed",
                onTap: () {
                  print("Clicked Needed");
                },
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Serie>>(
              future: series,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                List<Serie> seriesList = snapshot.data ?? [];
                seriesList.sort(compareSeries);
                seriesList = seriesList.reversed.toList();

                return GridView.builder(
                  itemCount: seriesList.length,
                  padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    mainAxisExtent: 160,
                  ),
                  itemBuilder: (context, index) {
                    final serie = seriesList[index];

                    return SerieContainer(
                      serie: serie,
                      containerColor: Color.fromARGB(255, 239, 206, 43),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
