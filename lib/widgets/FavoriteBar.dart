import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/FavoritesRepository.dart';

class FavoriteBar extends StatelessWidget {

  const FavoriteBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<FavoritesRepository>(
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${value.getFavoriteIds().length}'),
              const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ],
          );
        },
      ),
    );
  }

}