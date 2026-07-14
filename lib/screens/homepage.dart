import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myapp/widgets/tab_button.dart';
import 'package:myapp/models/pokemon_card.dart';
import '../services/api_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService api = ApiService();
  List<PokemonCard> cards = [];

  //void _loadImage() {
  //  setState(() {
  //    while (number < 200) {
  //      cards.add(
  //        new PokemonCard(
  //          id: (number.toString()),
  //          name: number.toString(),
  //          imageUrl:
  //              'https://assets.tcgdex.net/en/swsh/swsh3/$number/high.jpg',
  //        ),
  //      );
  //      number++;
  //    }
  //  });
  //}

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  Future<void> loadCards() async {
    final data = await api.getCards();

    setState(() {
      cards = data;
      cards.sort(compareCardIds);
    });
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
            child: GridView.builder(
              itemCount: cards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    // IMAGE
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          print(
                            "Clicked card ${cards[index].name} with url ${cards[index].imageUrl}",
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: cards[index].imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // BUTTON (top-right corner)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          print("Favorited card ${cards[index].name}");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
