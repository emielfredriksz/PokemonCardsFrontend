import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myapp/screens/card_page.dart';
import 'package:myapp/models/pokemon_card.dart' as card_class;
import 'package:myapp/widgets/greyable_image.dart';

class CardContainer extends StatelessWidget {
  final card_class.Card card;
  final int? userId;
  final Color containerColor;
  final VoidCallback cardOnTap;
  final VoidCallback checkOnTap;

  const CardContainer({
    super.key,
    required this.card,
    required this.userId,
    required this.containerColor,
    required this.cardOnTap,
    required this.checkOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cardOnTap();
      },
      child: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Container(
            child: greyableImage(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: card.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: card.imageUrl!,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported),
                        fit: BoxFit.contain,
                      )
                    : const Icon(Icons.image_not_supported),
              ),
              greyedOut: !card.inCollection && userId != null,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 5,
            right: 5,
            child: Container(
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              child: Text(
                "${card.name} #${card.localId}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          userId != null
              ? Positioned(
                  top: 2,
                  right: 2,
                  child: GestureDetector(
                    onTap: () {
                      checkOnTap();
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: card.inCollection
                            ? Colors.green
                            : Colors.white.withOpacity(0.85),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blueGrey, width: 1.5),
                      ),
                      child: Icon(
                        card.inCollection ? Icons.check : Icons.add,
                        size: 18,
                        color: card.inCollection ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                )
              : Text(""),
        ],
      ),
    );
  }
}
