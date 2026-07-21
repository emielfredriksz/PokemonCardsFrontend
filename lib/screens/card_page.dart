import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/models/pokemon_card.dart' as card_class;
import 'package:myapp/state/app_state.dart';
import 'package:myapp/widgets/greyable_image.dart';
import 'package:myapp/widgets/tab_button.dart';
import '../services/card_service.dart';
import 'package:provider/provider.dart';
import 'package:myapp/widgets/greyable_image.dart';
import 'package:myapp/widgets/card_container.dart';

class CardPage extends StatefulWidget {
  final String setId;
  const CardPage({super.key, required this.setId});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late List<card_class.Card> cards = [];
  late List<card_class.Card> displayedCards = [];
  late int? userId;
  late CardService service;

  @override
  void initState() {
    super.initState();

    service = context.read<CardService>();
    userId = context.read<AppState>().userId;

    loadCards();
  }

  Future<void> loadCards() async {
    final result = await service.getCardsPerSet(widget.setId, userId);

    setState(() {
      cards = result;
      displayedCards = cards;
      cards.sort(card_class.compareCardIds);
    });

    for (final card in result) {
      if (card.imageUrl != null) {
        precacheImage(NetworkImage(card.imageUrl!), context);
      }
    }
  }

  // TODO Emiel: add option for selection mode so you dont have to press the little checkbox, then this function needs a list option
  void toggleCollection(card_class.Card card) {
    setState(() {
      card.inCollection = !card.inCollection;
      card.changed = true;
    });

    // send API after UI updates
    service.updateUserCards(userId, cards);
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
                  setState(() {
                    displayedCards = cards;
                  });
                },
              ),
              TabButton(
                label: "Owned",
                onTap: () {
                  setState(() {
                    displayedCards = cards
                        .where((c) => c.inCollection)
                        .toList();
                  });
                },
              ),
              TabButton(
                label: "Needed",
                onTap: () {
                  setState(() {
                    displayedCards = cards
                        .where((c) => !c.inCollection)
                        .toList();
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              scrollCacheExtent: ScrollCacheExtent.viewport(3),
              itemCount: displayedCards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final card = displayedCards[index];

                return CardContainer(
                  card: card,
                  userId: userId,
                  containerColor: Colors.yellow,
                  cardOnTap: () {
                    print("${card.name} tapped");
                  },
                  checkOnTap: () {
                    toggleCollection(card);
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
