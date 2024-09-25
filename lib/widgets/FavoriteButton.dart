import 'package:exo3/models/breed.dart';
import 'package:exo3/repositories/FavoritesRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final Breed breed;

  const FavoriteButton({super.key, required this.breed});


  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesRepository>(
      builder: (context, value, child) {
        return IconButton(
          icon: Icon(
            value.isFavorite(breed) ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            if (value.isFavorite(breed)) {
              value.remove(breed);
            } else {
              value.add(breed);
            }
          },
        );
      },
    );
  }

}