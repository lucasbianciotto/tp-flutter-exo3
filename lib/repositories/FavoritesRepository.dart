import 'package:exo3/models/breed.dart';
import 'package:flutter/material.dart';

class FavoritesRepository extends ChangeNotifier {
  final List<Breed> breeds = [];

  int count() {
    return breeds.length;
  }

  void add(Breed breed) {
    breeds.add(breed);
    notifyListeners();
  }

  remove(Breed breed) {
    breeds.remove(breed);
    notifyListeners();
  }

  isFavorite(Breed breed) {
    return breeds.contains(breed);
  }

  get(String id) {
    return breeds.firstWhere((element) => element.id == id);
  }

  List<String> getFavoriteIds() {
    return breeds.map((breed) => breed.id).toList();
  }

  Breed getById(String id) {
    return breeds.firstWhere((breed) => breed.id == id);
  }



}