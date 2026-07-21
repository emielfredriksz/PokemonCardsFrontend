import 'package:flutter/material.dart';
import 'package:myapp/models/pokemon_set.dart';
import 'package:myapp/screens/card_page.dart';
import 'package:myapp/state/app_state.dart';
import 'package:myapp/widgets/tab_button.dart';
import 'package:myapp/models/pokemon_card.dart';
import '../services/set_service.dart';
import 'package:provider/provider.dart';
import 'package:myapp/widgets/set_container.dart';

class SetPage extends StatefulWidget {
  final String serieId;
  const SetPage({super.key, required this.serieId});

  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  late Future<List<Set>> sets;

  @override
  void initState() {
    super.initState();

    final service = context.read<SetService>();
    sets = service.getSetsPerSerie(widget.serieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // LEFT SIDEBAR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              TabButton(
                label: "All",
                onTap: () {
                  print("Clicked All");
                },
              ),
              TabButton(
                label: "Owned",
                onTap: () {
                  print("Clicked Owned");
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
            child: FutureBuilder<List<Set>>(
              future: sets,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                List<Set> setsList = snapshot.data ?? [];
                setsList.sort(compareSets);
                setsList = setsList.reversed.toList();

                return GridView.builder(
                  itemCount: setsList.length,
                  padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.6,
                    mainAxisExtent: 140,
                  ),
                  itemBuilder: (context, index) {
                    final set = setsList[index];

                    return SetContainer(
                      set: set,
                      containerColor: Color.fromARGB(255, 198, 198, 198),
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
