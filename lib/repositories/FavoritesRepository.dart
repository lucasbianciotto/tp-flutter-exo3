import 'package:exo3/database/CatsDatabase.dart';
import 'package:exo3/models/breed.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Breed> breeds = [];

  final _tableName = 'favorites';
  final Database database = CatsDatabase().database;

  FavoritesRepository() {
    database.query(_tableName).then((value) {
      breeds = value.map((e) => Breed.fromMap(e)).toList();
      notifyListeners();
    });
  }


  int count() {
    return breeds.length;
  }

  void add(Breed breed) {
    breeds.add(breed);
    database.insert(_tableName, breed.toMap());
    notifyListeners();
  }

  remove(Breed breed) {
    breeds.add(breed);
    database.delete(_tableName, where: 'id = ?', whereArgs: [breed.id]);
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