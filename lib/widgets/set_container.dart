import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myapp/screens/card_page.dart';
import 'package:myapp/models/pokemon_set.dart';

class SetContainer extends StatelessWidget {
  final Set set;
  final Color containerColor;

  const SetContainer({
    super.key,
    required this.set,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CardPage(setId: set.id)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Column(
              spacing: 10,
              children: [
                Container(
                  height: 70,
                  width: 140,
                  child: set.logo != null
                      ? CachedNetworkImage(
                          imageUrl: set.logo!,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.image_not_supported),
                          fit: BoxFit.contain,
                        )
                      : const Icon(Icons.image_not_supported),
                ),
                Container(
                  height: 40,
                  alignment: AlignmentGeometry.center,
                  child: Text(set.name, textAlign: TextAlign.center),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              width: 20,
              height: 20,
              child: ClipOval(
                child: set.symbol != null
                    ? CachedNetworkImage(
                        imageUrl: set.symbol!,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported),
                        fit: BoxFit.contain,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
