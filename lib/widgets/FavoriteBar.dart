import 'package:exo3/pages/Favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/FavoritesRepository.dart';

class FavoriteBar extends StatelessWidget {

  const FavoriteBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesRepository>(
      builder: (context, value, child) {
        return ElevatedButton.icon(
            icon: const Icon(Icons.favorite),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              iconColor: Colors.red,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritePage()));
            },
            label: Text(value.getFavoriteIds().length.toString()),
        );
      },
    );
  }

}