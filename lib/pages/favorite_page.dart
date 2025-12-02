import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _HomePageState();
}

class _HomePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            backgroundColor: colorTheme.surfaceContainerLow,
            foregroundColor: colorTheme.onSurface,
            elevation: 5,
            expandedHeight: 20,
            title: Text('Favorite Books', style: textTheme.displayMedium),
          ),
        ],
      ),
    );
  }
}
