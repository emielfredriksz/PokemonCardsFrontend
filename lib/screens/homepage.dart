import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myapp/widgets/tab_button.dart';
import 'package:myapp/models/pokemon_card.dart';
import '../services/card_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        ],
      ),
    );
  }
}
