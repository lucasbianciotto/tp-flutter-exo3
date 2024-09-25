import 'package:exo3/models/breed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/FavoritesRepository.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    // Récupérer l'instance de FavoritesRepository via le provider
    var favorites = Provider.of<FavoritesRepository>(context);

    // Obtenir la liste des IDs des favoris (qui sont des String apparemment)
    final favoriteIds = favorites.getFavoriteIds();  // Cette méthode renvoie la liste des IDs

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteIds.isNotEmpty
          ? ListView.builder(
        itemCount: favoriteIds.length,
        itemBuilder: (context, index) {
          final favoriteId = favoriteIds[index];
          final breed = favorites.getById(favoriteId);

          return ListTile(
            title: Text(breed.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                favorites.remove(breed);
              },
            ),
          );
        },
      )
          : const Center(
        child: Text('No favorites added yet'),
      ),
    );
  }
}
