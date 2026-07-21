import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myapp/screens/set_page.dart';
import 'package:myapp/models/pokemon_serie.dart';

class SerieContainer extends StatelessWidget {
  final Serie serie;
  final Color containerColor;

  const SerieContainer({
    super.key,
    required this.serie,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SetPage(serieId: serie.id)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          spacing: 10,
          children: [
            Container(
              height: 90,
              width: 200,
              child: serie.logo != null
                  ? CachedNetworkImage(
                      imageUrl: serie.logo!,
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
              child: Text(serie.name, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
